Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUHMHWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUHMHWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUHMHWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:22:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48792 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269015AbUHMHWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:22:51 -0400
Date: Fri, 13 Aug 2004 08:22:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040813072250.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <1092341803.22458.37.camel@localhost.localdomain> <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org> <20040813065902.GB2321@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813065902.GB2321@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 08:59:03AM +0200, Jens Axboe wrote:
 
> While that does make sense, it would be more code to fold them together
> than what is currently there. SCSI_IOCTL_SEND_COMMAND is really
> horrible, the person inventing that API should be subject to daily
> public ridicule.

Introduced in 0.96a, between Apr 9 1992 and Apr 24 1992; part of initial
SCSI merge, so probably existed earlier than that (ultrastor claims to
be 1991, aha1542 appears to have started in January 1992).  Drew Eckhardt,
most likely...
