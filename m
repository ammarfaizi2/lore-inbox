Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUBXVnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUBXVnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:43:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:42662 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262485AbUBXVm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:42:57 -0500
Date: Tue, 24 Feb 2004 13:41:07 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Kai Makisara <Kai.Makisara@metla.fi>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, kai.makisara@kolumbus.fi
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040224214107.GB2045@kroah.com>
References: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi> <20040224170412.GA31268@kroah.com> <1077642529.1804.170.camel@mulgrave> <20040224171629.GA31369@kroah.com> <20040224101512.A19617@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224101512.A19617@beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:15:12AM -0800, Patrick Mansfield wrote:
> On Tue, Feb 24, 2004 at 09:16:29AM -0800, Greg KH wrote:
> 
> > 
> > Can you print out the sysfs tree this patch creates?
> > 
> > What's that "tape" symlink for?  Does it go from the scsi device in
> > /sys/devices/... to the class device?  Or the other way around?
> > 
> > Other than that question, the patch looks sane to me.
> 
> Current 2.6 kernel default names are of the form: st[0-9]m[0-3][n]
> 
> Current /dev naming is of the form: [n]st[0-9][alm]
> 
> Should the st kernel names be changed to map to current /dev names?

Yes, to make it easier for everyone, they should.  Any reason why the
kernel names are currently different from what we have in
Documentation/devices.txt?  I really feel we should follow the standard
here :)

thanks,

greg k-h
