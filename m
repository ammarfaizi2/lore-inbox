Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWJ3Rtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWJ3Rtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWJ3Rtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:49:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:5847 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161251AbWJ3Rtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:49:55 -0500
Subject: Re: [PATCH] jfs: Add splice support
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Daniel Drake <ddrake@brontes3d.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <1162229359.7280.20.camel@systems03.lan.brontes3d.com>
References: <20061030163148.2412D7B40A0@zog.reactivated.net>
	 <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
	 <1162229359.7280.20.camel@systems03.lan.brontes3d.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 11:49:45 -0600
Message-Id: <1162230585.24229.4.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 12:29 -0500, Daniel Drake wrote:
> > Answer: I would have had to test it.
> > 
> > I'm assuming you did?
> 
> Yep:
> 
> Created a 100mb file from /dev/urandom on an ext3 partition
> Used splice-cp to copy it onto a JFS partition
> Used splice-cp to copy it from that JFS partition onto another JFS
> partition
> 
> I checked md5sums at all stages, seems to work fine.

Great.  I added it to the jfs git tree.

Shaggy

> 
> Thanks!
> Daniel
> 
> 
-- 
David Kleikamp
IBM Linux Technology Center

