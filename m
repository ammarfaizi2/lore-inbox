Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282958AbRLDJhY>; Tue, 4 Dec 2001 04:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282994AbRLDJhP>; Tue, 4 Dec 2001 04:37:15 -0500
Received: from tangens.hometree.net ([212.34.181.34]:49593 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S282958AbRLDJg6>; Tue, 4 Dec 2001 04:36:58 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Date: Tue, 4 Dec 2001 09:36:56 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9ui5fo$3oe$1@forge.intermeta.de>
In-Reply-To: <lm@bitmover.com> <200112031208.fB3C8CsE032561@pincoya.inf.utfsm.cl>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1007458616 7687 212.34.181.4 (4 Dec 2001 09:36:56 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 4 Dec 2001 09:36:56 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

Hi,

>> Nor will you find any match with 4 or 8 CPU systems, except in very rare
>> cases.  Yet changes go into the system for 8 way and 16 way performance.
>> That's a mistake.

>And you are proposing a fork for handling exactly this? I don't get it...

[Ah, and I've sworn that I won't participate in this thread again...]

99.99% of your userbase have one or two processors. 99.999% of your
userbase have less than 8 processors.

It simply doesn't make sense to design something for 128+ Processors
if noone uses it. Especially if it puts a penalty on the user base
with one or two processors. Then such a design is actively hurting
your user base. And this is nonsense. That's why the design goes
1->2->4->8. We got SMP once a core developer got a sponsored SMP
board. Not because Linus designed his OS with "I want to scale to lots
of processors I can only dream of". Along that road lies madness (and
maybe GNU Hurd ;-) ).

I actually have five (at a customers site) eight-way machines. 
Unfortunately now they all run Windows 2000 (Datacenter Edition
(TM)). But if the "eight-way" support would hurt the "two way"
machines, I'd advocate to put that code at least under a compile
switch.

Actually I do like the idea in Larrys' paper. It doesn't hurt beyond
eight way, because the next eight processors are their own
"system". Just because it doesn't hurt the smaller boxes (much).

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
