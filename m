Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSKUQql>; Thu, 21 Nov 2002 11:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbSKUQql>; Thu, 21 Nov 2002 11:46:41 -0500
Received: from mail.hometree.net ([212.34.181.120]:8340 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266852AbSKUQqk>; Thu, 21 Nov 2002 11:46:40 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [RFC/CFT] Separate obj/src dir
Date: Thu, 21 Nov 2002 16:53:47 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <arj32r$fek$1@forge.intermeta.de>
References: <20021119201110.GA11192@mars.ravnborg.org> <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037897627 18696 212.34.181.4 (21 Nov 2002 16:53:47 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 21 Nov 2002 16:53:47 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

>On Tue, 19 Nov 2002, Sam Ravnborg wrote:

>> Based on some initial work by Kai Germaschewski I have made a
>> working prototype of separate obj/src tree.
>> 
>> Usage example:
>> #src located in ~/bk/linux-2.5.sepobj
>> mkdir ~/compile/v2.5
>> cd ~/compile/v2.5
>> sh ../../kb/v2.5/kbuild

>[SNIPPED...]

>I have a question; "What problem is this supposed to solve?"
>This looks like a M$ism to me. Real source trees don't
>look like this. If you don't have write access to the source-
>code tree, you are screwed on a real project anyway. That's
>why we have CVS, tar and other tools to provide a local copy.

Having Trees read-only checked out? Having Trees on "pseudo filesystems"
backed by a SCM? 

This is the same thing we do in Java Land for ages. I personally like it
buy your taste may vary.

	Regards
		Henning

-- 

"In einem Abwägungsprozess, wollen wir weiter regieren, hat sich die
SPD und die Bundesregierung und auch der Bundesfinanzminister fürs
Weiterregieren entschieden und gegen die Ehrlichkeit" -- Oswald
Metzger, Bündnis '90/Die Grünen, 12.11.2002

-- 
Henning Schmiedehausen     "Interpol und Deutsche Bank, FBI und
hps@intermeta.de            Scotland Yard, Flensburg und das BKA
henning@forge.franken.de    haben unsere Daten da." -- Kraftwerk, 1981
