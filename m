Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265670AbTFVSoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTFVSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:44:11 -0400
Received: from mail.hometree.net ([212.34.181.120]:7636 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S265670AbTFVSoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:44:00 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Date: Sun, 22 Jun 2003 18:58:04 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bd4u7s$jkp$1@tangens.hometree.net>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622103251.158691c3.akpm@digeo.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1056308284 20121 212.34.181.4 (22 Jun 2003 18:58:04 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 22 Jun 2003 18:58:04 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

Your problem is not the compiler but the build tool / system which
forces you to recompile all of your kernel if you change only small
parts.

	Regards
		Henning


>Daniel Phillips <phillips@arcor.de> wrote:
>>
>> As for compilation speed, yes, that sucks.  I doubt there's any rational 
>>  reason for it, but I also agree with the idea that correctness and binary 
>>  code performance should come first, then the compilation speed issue should 
>>  be addressed.

>No.  Compilation inefficiency directly harms programmer efficiency and the
>quality and volume of code the programmer produces.  These are surely the
>most important things by which a toolchain's usefulness should be judged.

>I compile with -O1 all the time and couldn't care the teeniest little bit
>about the performance of the generated code - it just doesn't matter.

>I'm happy allowing those thousands of people who do not compile kernels all
>the time to shake out any 3.2/3.3 compilation problems.


>Compilation inefficiency is the most serious thing wrong with gcc.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

--- Quote of the week: "Never argue with an idiot. They drag you down
to their level, then beat you with experience." ---

