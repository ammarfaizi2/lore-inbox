Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSLOO6w>; Sun, 15 Dec 2002 09:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSLOO6w>; Sun, 15 Dec 2002 09:58:52 -0500
Received: from smtp-server4.tampabay.rr.com ([65.32.1.43]:39093 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S261660AbSLOO6w>; Sun, 15 Dec 2002 09:58:52 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Dave Jones" <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel for Pentium 4 hyperthreading?
Date: Sun, 15 Dec 2002 10:07:43 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJAEICDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20021215134408.GA20335@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What I have is, indeed, a hyperthread-enabled Pentium 4. They aren't common;
I obtained this one direct from Intel through their Early Access Program.
The proof in the pudding is that both Windows XP and Linux 2.5.51 recognize
it as having "two" processors. The motherboard is an Intel Maryville2 (i850E
chipset), with an option to enable/disable HT on the first BIOS set-up
screen.

> Note that just because /proc/cpuinfo shows 'ht' does not mean you can
> use it in hyperthreaded mode. To do that, you also have to have >1
> sibling in the physical package. Non-Xeon type P4's don't have the
> extra sibling, so don't function as a hyperthreaded CPU.

Mine does, and so will any 3.06 or 3.6 GHz Pentium 4.

As it is, I'm past the worst of my troubles (knock on wood!) We'll see what
happens in the coming days the machine gets stressed. It looks stable with
2.5.51 -- so I guess I'm now a Linux kernel beta tester... ;)

Thanks much.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

