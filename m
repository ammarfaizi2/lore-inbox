Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136421AbRASVzI>; Fri, 19 Jan 2001 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136717AbRASVy6>; Fri, 19 Jan 2001 16:54:58 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:6715 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S136421AbRASVyl>; Fri, 19 Jan 2001 16:54:41 -0500
Date: Fri, 19 Jan 2001 15:54:35 -0600
From: Matthew Fredrickson <lists@frednet.dyndns.org>
To: "John O'Donnell" <johnod@voicefx.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010119155435.A32255@frednet.dyndns.org>
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org> <3A677D17.8000701@voicefx.com> <20010118234225.A7210@www.mwob.org.uk> <20010119155333.A2050@suse.cz> <3A686E59.AB37B478@voicefx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A686E59.AB37B478@voicefx.com>; from johnod@voicefx.com on Fri, Jan 19, 2001 at 11:42:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 11:42:01AM -0500, John O'Donnell wrote:
> Vojtech Pavlik wrote:
> > 
> > On Thu, Jan 18, 2001 at 11:42:25PM +0000, Howard Johnson wrote:
> > > On Thu, Jan 18, 2001 at 06:32:39PM -0500, John O'Donnell wrote:
> > > > Matthew Fredrickson wrote:
> > > >
> > > > I have the ASUS CUV4X.
> > > > VIA vt82c686a (cf/cg) IDE UDMA66 controller on pci0:4.1
> > > > I also run DMA66 with no problems here.
> > > >
> > > > I never have seen any issues with the PS/2 mouse and X.
> > > > I use the Logitech cordless wheel mouse.  I use the "MouseManPlusPS/2"
> > > > driver in XFree.  When I was first setting this up (about a year ago)
> > > > I had the problems you mention.  I read an article on setting up your
> > > > scroll wheel in X and it said to use the IMPS/2 setting.  This was
> > > > nothing but trouble, till I RTFM on XFree and mice and found my solution.
> > > > Can you tell us what kind of mouse this is and how you have it set up in
> > > > XFree.
> > >
> > > I'm seeing the same mouse problems... fine under 2.2.x, but jumps around under
> > > a couple of 2.4.x releases (2.4.0-test6, IIRC, and 2.4.1-pre7). I find it odd
> > > that if it isn't a kernel-related problem, that it's only manifesting itself
> > > under 2.4.
> > >
> > > I'm running a slot A athlon on an abit KA7-100.
> > 
> > My bet is ACPI/powermanagement messing with it ...
> 
> Forgive me.  I know _nothing_ about Power Management resources.
> What kind of resouces would PM use to interfere with the mouse.
> FYI I have power management turned off in my BIOS and in the kernel
> I have CONFIG_APM and ONLY  CONFIG_APM_REAL_MODE_POWER_OFF.
> How does that compare with the rest of you?

The same for me if I remember correctly (I've been dinking around on the
linux side of my box sparingly with X not working correctly), though I
might have compiled in some other ACPI stuff if I thought it looked cool
(heh).  My trouble is that I figure that the kernel must have _something_
to do with it since my problem got slightly better since upgrading from
2.2.18 to 2.4.0.  just my .02

Matthew Fredrickson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
