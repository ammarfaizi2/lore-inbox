Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTHZUaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHZUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:30:22 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:58468 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262726AbTHZUaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:30:15 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Steven Cole <elenstev@mesatop.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Oleg Drokin <green@namesys.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Alex Zarochentsev <zam@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826202649.GD1258@matchmail.com>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>
	 <20030826182609.GO5448@backtop.namesys.com>
	 <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
	 <20030826194321.GA25730@namesys.com>
	 <1061927482.1666.36.camel@spc9.esa.lanl.gov>
	 <20030826200530.GC1258@matchmail.com>
	 <1061928831.1666.46.camel@spc9.esa.lanl.gov>
	 <20030826202649.GD1258@matchmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061929549.1670.49.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 26 Aug 2003 14:25:49 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 14:26, Mike Fedyk wrote:
> On Tue, Aug 26, 2003 at 02:13:51PM -0600, Steven Cole wrote:
> > On Tue, 2003-08-26 at 14:05, Mike Fedyk wrote:
> > > Can you try ext3 with -o data=writeback, as well as xfs & reiser3?
> > 
> > [root@spc1 /]# umount /dev/hda9
> > [root@spc1 /]# mount -t ext3 -o data=writeback /dev/hda9 /home
> > [root@spc1 /]# mount -t reiserfs /dev/hda10 /share_r
> > [root@spc1 /]# mount -t xfs /dev/hda12 /share_x
> > 
> 
> Please use the same partition for all filesystem tests, otherwise you will
> be showing results that need to be adjusted for inner-spindle disk speed.

Good point.  That will take a little more time, but at least the results
will be more meaningful.  Thanks.

Steven

