Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268945AbRG0TmU>; Fri, 27 Jul 2001 15:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268939AbRG0TmI>; Fri, 27 Jul 2001 15:42:08 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:18181 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S268060AbRG0Tly>; Fri, 27 Jul 2001 15:41:54 -0400
Message-ID: <3B62186E.B89C29E8@free.fr>
Date: Fri, 27 Jul 2001 21:42:06 -0400
From: PEIFFER Pierre <ppeiffer@free.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA KT133A / athlon / MMX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi !

	I'm a recent user of the duo VIA KT133A chipset/Athlon CPU and after
compiling a customized kernel and booting on it, I fall on kernel panic
at boot time, just little time after starting the init process.
	After some search and test, it appears that it was the K7 mmx routines
which cause the crash
	Using the "default" routines by replacing #ifdef CONFIG_MK7 by #ifdef 0
solves the problem.
	I just wanted to mention that, here, this crash is systematic with
k7-mmx routines.

	I also just wanted to know the current status of this problem since I
have not found clear answer on the different threads about this topic.
As I understand, this problem does not exist on every athlon but only on
some which work with the VIA KT133 chipset ? Right ?
	
	Anyway, feel free to ask me more information if needed and please,
CC'ed me personally the answers/comments because I'm not subscribed to
the LKML.

Config.:
ABIT KT7A (without RAID)
Athlon 1.2 GHz
256 Meg RAM
FSB at 133 MHz
(Other card description is not imortant I think)
Running Mandrake 8.0 (*) (at home)
with kernel 2.4.7 (or 2.4.6) compiled with gcc 3.0 (same pb with gcc
2.96 (non-official, I know))

(*) In fact, this distribution has a special startup and switch
immediatly (at startup) in a graphic mode for showing the start of the
runlevel. And I think/suppose that this definitly causes the crash.

	Thanks,

	Pierre
