Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283272AbRLDSmA>; Tue, 4 Dec 2001 13:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281547AbRLDSkQ>; Tue, 4 Dec 2001 13:40:16 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:46217 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S281659AbRLDSjf>; Tue, 4 Dec 2001 13:39:35 -0500
To: raul@viadomus.com, trini@kernel.crashing.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16BKeT-0001zt-00@DervishD.viadomus.com>
Date: Tue, 4 Dec 2001 19:50:45 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tom :))

>>     Why must I install Python in order to compile the kernel? I don't
>> understand this. I think there are better alternatives, but kbuild
>> seems to be imposed any way.
>kbuild != CML2.

    Yes, sorry, just a mental shortcircuit ;))

>It all boils down to the current 'language' having no
>real definitive spec, and having 3+ incompatible parsers.

    Yes, I know and I think that is a good thing to have a good
configuration language, and it means having a good specification and
a good parser. Just I don't think that 6Mb-Python is a good way to
write a good parser. Well, I'm sure that I cannot do better (right
now), so I don't want to flame anyone with this, just want to show my
opinion (shared by many, although) and show the negative points of
having Python as a dependence.

>The spec for CML2 is out there, and there's even a CML2-in-C project.

    How advanced? Where is the spec, please?

>that project out and then convince Linus to include it.

    Hard job... Convincing Linus, I mean ;)))

>>     The kernel should depend just on the compiler and assembler, IMHO.
>The right tools for the right job.  C is good for the kernel.  Python is
>good at manipulating strings.

    Well, IMHO Python is good only in being big and doing things
slow, but... why the parser cannot be built over flex/bison?. That
way it can be 'pregenerated' and people won't need additional tools
to build the kernel.

    Raúl
