Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWBOVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWBOVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWBOVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:39:59 -0500
Received: from smtp1.ist.utl.pt ([193.136.128.21]:21228 "EHLO smtp1.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1751300AbWBOVj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:39:59 -0500
From: Claudio Martins <ctpm@ist.utl.pt>
To: Nohez <nohez@cmie.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Wed, 15 Feb 2006 21:42:47 +0000
User-Agent: KMail/1.7.2
Cc: Mark Fasheh <mark.fasheh@oracle.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0602152244050.3591-100000@mars.cmie.ernet.in>
In-Reply-To: <Pine.LNX.4.33.0602152244050.3591-100000@mars.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602152142.48028.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 15 February 2006 17:50, Nohez wrote:
>
> Now started bonnie++ on one node while the same volume on the other node
> is mounted and is in quiescent stage. Its been more than 5 hours now
> and both the nodes are up & running. Seeing some very high load of >8 at
> times on the node running bonnie++. Test node has 4GB RAM and bonnie++
> is creating files of 8GB to test IO performance. Will start bonnie++
> on both the nodes concurrently later.
>

 Nice. It'll be interesting when you start concurrent tests. I think the last 
fixes from -mm made it better, but I'm still getting DLM errors and processes 
hung in D state when using tar concurrently reading kernel trees on 3 nodes. 
I'd like to know if you'll get the same or not.
 I'll be sending kernel messages and a more complete report later this 
evening. 

Regards

Claudio

