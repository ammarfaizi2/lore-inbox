Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRB0K1c>; Tue, 27 Feb 2001 05:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRB0K1W>; Tue, 27 Feb 2001 05:27:22 -0500
Received: from [212.115.175.146] ([212.115.175.146]:58620 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129699AbRB0K1L>; Tue, 27 Feb 2001 05:27:11 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F1D@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: sean@dev.sportingbet.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Date: Tue, 27 Feb 2001 11:35:57 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have already written a 2.2 implementation which does not suffer from
these 
> problems.

Yes, someone pointed me at it. To be honest (and with all due respect): I
found
it to be a bit over-complicated. Like; in my opinion it's only usefull to
have
absolute random chosen PIDs, or not. Not all those options are needed in my
opinion.

> It was rejected because Alan Cox (and others) felt it only provided 
> security through obscurity. 

Yeah, well, yeah. My patch wasn't actually ment to be included in the main-
kernel. I agree with the security-by-obscurity argument altough I think it's
_not ALWAYS_ a bad thing.
What I am trying to say is: I agree that sofware should be written so that
they can't be exploited in one way or another. But since software is written
by humans, it's likely that bugs stay always in. Furthermore; it's always
possible that in the future new exploits are invented which exploit things
the original programmer didn't think of, and also; new libcs might have
security-problems which affect your software. To prevent that your system
gets cracked by some script-kiddie, I found it a good thing to patch the
mainstream-kernel with patches that disable executable stacks, make the
/proc filesystem more restricted, etc. etc. And in my quest for creating a
secure-as-possible system which anticipates on future exploits I found that
using random PIDs is a good thing.
I hope I made myself clear; english is not my native language which makes
this a rather big chalenge.


Greetings,
Folkert van Heusden
[ www.vanheusden.com ]
