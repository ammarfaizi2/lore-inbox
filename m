Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289385AbSA2OgW>; Tue, 29 Jan 2002 09:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSA2OgN>; Tue, 29 Jan 2002 09:36:13 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:43441 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289385AbSA2OgA>; Tue, 29 Jan 2002 09:36:00 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: fonts corruption with 3dfx drm module
Date: Tue, 29 Jan 2002 15:32:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Mark Zealey <mark@zealos.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201290838560.20095-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0201290838560.20095-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020129143609Z289385-13996+13878@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 29. January 2002 07:45, Zwane Mwaikambo wrote:
> On Mon, 28 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > MTRR, of course (do you like 2D and even 3D hardware accelerated without
> > MTRR?), FB, no, chipset is a AMD 750 (Irongate C4), using X 4.1.99.1 DRI
> > CVS.
>
> The reason why i ask is because i was experiencing font corruption with
> MTRRs enabled and X segfaulting with 4.x and a VIA Apollo pro

That make sense.

> (mostly because with 3.3.6 i never setup the MTRRs myself)

We 3.3.6 you have to do it some times.

> and a friend of mine was seeing corruption plus the occasional lockup with
> his KT133. Disabling MTRRs solved both our lockup problems,

This could be all the VIA/mobo/BIOS problems widely discussed.
Maybe the latest AGP GART issue.

> mind you i soon switched back to my older 440BX setup and my problems went
> away.

Some point at Intel 'cause they "designed" the AGP port with UP only in mind 
and AMD's Athlon/Duron is designed for SMP from the ground.

> I also asked about FB because my particular card (ATI Rage IIC) never gets
> MTRRs working in X4.1 unless i have it FB enabled.

Have you ever looked at XFree and/or DRI devel?
I think this could and should be solved. Without notice nobody cares...

You should definitely go with XFree86 4.2.0. It is out and most distros have 
packages available. Then look deeper into the MTRR problem.

Good luck.
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
