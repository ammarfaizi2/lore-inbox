Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135563AbRASQ4f>; Fri, 19 Jan 2001 11:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRASQ4Z>; Fri, 19 Jan 2001 11:56:25 -0500
Received: from linsrv.voicefx.com ([209.146.119.132]:9491 "EHLO
	linsrv.voicefx.com") by vger.kernel.org with ESMTP
	id <S132486AbRASQ4M>; Fri, 19 Jan 2001 11:56:12 -0500
Message-ID: <3A686E59.AB37B478@voicefx.com>
Date: Fri, 19 Jan 2001 11:42:01 -0500
From: "John O'Donnell" <johnod@voicefx.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, merlin@mwob.org.uk,
        lists@frednet.dyndns.org, linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org> <3A677D17.8000701@voicefx.com> <20010118234225.A7210@www.mwob.org.uk> <20010119155333.A2050@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Thu, Jan 18, 2001 at 11:42:25PM +0000, Howard Johnson wrote:
> > On Thu, Jan 18, 2001 at 06:32:39PM -0500, John O'Donnell wrote:
> > > Matthew Fredrickson wrote:
> > >
> > > I have the ASUS CUV4X.
> > > VIA vt82c686a (cf/cg) IDE UDMA66 controller on pci0:4.1
> > > I also run DMA66 with no problems here.
> > >
> > > I never have seen any issues with the PS/2 mouse and X.
> > > I use the Logitech cordless wheel mouse.  I use the "MouseManPlusPS/2"
> > > driver in XFree.  When I was first setting this up (about a year ago)
> > > I had the problems you mention.  I read an article on setting up your
> > > scroll wheel in X and it said to use the IMPS/2 setting.  This was
> > > nothing but trouble, till I RTFM on XFree and mice and found my solution.
> > > Can you tell us what kind of mouse this is and how you have it set up in
> > > XFree.
> >
> > I'm seeing the same mouse problems... fine under 2.2.x, but jumps around under
> > a couple of 2.4.x releases (2.4.0-test6, IIRC, and 2.4.1-pre7). I find it odd
> > that if it isn't a kernel-related problem, that it's only manifesting itself
> > under 2.4.
> >
> > I'm running a slot A athlon on an abit KA7-100.
> 
> My bet is ACPI/powermanagement messing with it ...

Forgive me.  I know _nothing_ about Power Management resources.
What kind of resouces would PM use to interfere with the mouse.
FYI I have power management turned off in my BIOS and in the kernel
I have CONFIG_APM and ONLY  CONFIG_APM_REAL_MODE_POWER_OFF.
How does that compare with the rest of you?
Johnny O

-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
