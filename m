Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbTATTkx>; Mon, 20 Jan 2003 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbTATTkV>; Mon, 20 Jan 2003 14:40:21 -0500
Received: from mail.webmaster.com ([216.152.64.131]:37628 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266846AbTATTjQ> convert rfc822-to-8bit; Mon, 20 Jan 2003 14:39:16 -0500
From: David Schwartz <davids@webmaster.com>
To: <brand@jupiter.cs.uni-dortmund.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 20 Jan 2003 11:43:48 -0800
In-Reply-To: <200301201552.h0KFquMR001681@eeyore.valparaiso.cl>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120194430.AAA20700@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 16:52:56 +0100, Horst von Brand wrote:

>>    I think you're ignoring the way the GPL defines the "source 
>>code".
>>
>>The GPL defines the "source code" as the preferred form for
>>modifying
>>the program. If the preferred form of a work for purposes of
>>modifying it is live access to a BK repository, then that's the
>>"source code" for GPL purposes.

>You are a lawyer working in this area, and so can cite chapter and
>verse
>where this definition was made (the GPL text is rather vague)?

	Nobody knows, that's definitely part of the problem. If you 
genuinely want to make a good faith effort to comply with the GPL, 
I'm not sure what you can do other than guess.

>Anyway, Andreas Dilger is (curiously) right AFAIU: Linus has _never_
>distributed a binary to anybody AFAIK, so he is under no obligation
>by the
>GPL do give out any form of source. Furthermore, as he is (in the
>editor
>sense at least) copyright holder for the whole source, he isn't
>bound by
>the GPL in any case. ;-)

	The problem then occurs with companies like RedHat. They distribute 
binaries, so they must distribute the source in the preferred form 
for making modifications to it. *If* metainformation in Linus' BK 
tree is part of the preferred version of the work for the purposes of 
making modifications to it, then RedHat *cannot* comply with the GPL.

	Checking source code out of a repository is an obfuscatory act that 
separates the raw source code from the rationale for that source 
code. It's equivalent to stripping comments. The GPL does not allow 
you to obfuscate the source, so if all *you* have is obfuscated 
source, *you* cannot ship binaries.

	I don't think this is currently an issue for the Linux kernel. 
However, it may well be an issue for projects using things like 
sourceforge or using proprietary file formats to hold portions of 
their source.

	DS


