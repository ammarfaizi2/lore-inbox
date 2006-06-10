Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWFJM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWFJM4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWFJM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:56:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:60115 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751509AbWFJM4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:56:41 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Date: Sat, 10 Jun 2006 14:56:35 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
References: <200606082257.23286.o.bock@fh-wolfenbuettel.de> <20060609104541.GB16232@elf.ucw.cz> <20060609225015.GE17807@kroah.com>
In-Reply-To: <20060609225015.GE17807@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606101456.35436.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
I submitted the patch again a few hours ago. Now the tabs are still there 
where they belong and it's a diff against 2.6.17-rc6.

Have a look at: http://lkml.org/lkml/2006/6/9/398

Thanks, Oliver

On Saturday 10 June 2006 00:50, Greg KH wrote:
> On Fri, Jun 09, 2006 at 12:45:41PM +0200, Pavel Machek wrote:
> > On ??t 08-06-06 22:57:18, Oliver Bock wrote:
> > > From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
> > >
> > > This is a new driver for the Cypress CY7C63xxx mirco controller series.
> > > It currently supports the pre-programmed CYC63001A-PC by AK Modul-Bus
> > > GmbH. It's based on a kernel 2.4 driver (cyport) by Marcus Maul which I
> > > ported to kernel 2.6 using sysfs. I intend to support more controllers
> > > of this family (and more features) as soon as I get hold of the
> > > required IDs etc. Please see the source code's header for more
> > > information.
> >
> > I see "a" letters here tabs should have been. You probably need to
> > resend...
>
> It's just mime, my tools can handle it, I hope...
>
> > > Please CC me as I'm not yet subscribed to LKML. Any comments are
> > > welcome. Special thanks to Greg K-H for his helpful support!
> > >
> > > diff against 2.6.16.19
> >
> > Ugh, and new drivers should really go against 2.6.17-rcX.
>
> Stand-alone drivers should work ok, I'll test this one and see...
>
> thanks,
>
> greg k-h
