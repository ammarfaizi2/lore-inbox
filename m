Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbTFWVRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTFWVRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:17:45 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:55136 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265527AbTFWVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:16:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: "Szonyi Calin" <sony@etc.utt.ro>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>
Subject: Re: [Jfs-discussion] [PATCH] Re: Jfs problems
Date: Mon, 23 Jun 2003 16:30:50 -0500
User-Agent: KMail/1.4.3
Cc: <linux-kernel@vger.kernel.org>
References: <35119.194.138.39.55.1056364461.squirrel@webmail.etc.utt.ro> <200306231533.49595.shaggy@austin.ibm.com>
In-Reply-To: <200306231533.49595.shaggy@austin.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306231630.51359.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 June 2003 15:33, Dave Kleikamp wrote:
>
> I think I found the problem.  The patch below should fix it.  I will
> try to reproduce the problem and verify that this patch works.

I wasn't able to reproduce the trap (which depends on the contents of 
uninitialized memory) but I was able to verify that it fixes a problem 
where changes to a directory got lost.  I'm convinced the patch is 
good.

-- 
David Kleikamp
IBM Linux Technology Center

