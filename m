Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTENN6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTENN5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:57:48 -0400
Received: from mail.hometree.net ([212.34.181.120]:26286 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262308AbTENN4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:56:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: What exactly does "supports Linux" mean?
Date: Wed, 14 May 2003 14:09:33 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b9timt$e3m$3@tangens.hometree.net>
References: <200305131114_MC3-1-38B0-3C13@compuserve.com> <yw1x3cjifutq.fsf@zaphod.guide>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1052921373 14454 212.34.181.4 (14 May 2003 14:09:33 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 14 May 2003 14:09:33 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=) writes:

>Even when they do, it's often far from what I would call "Linux
>support".  I've seen vendor drivers that made such assumptions about
>the machine that they would only work on IA-32 machines.  I'm talking
>about things like assuming that sizof(int) == sizeof(void *) == 4, or
>that physical memory addresses are the same seen from the CPU and from
>the PCI bus.

This is why "the other OS" has the WHQL, signs drivers and generally
does many things (including getting some cash from driver vendors) to
ensure (and enforce!) that the "designed for Windows xxx" logo really
helps customers.

And might be one of the reasons why they're releasing a new 'kernel'
version only once every two years and go through many pains to ensure,
that old drivers still run most of the times. This is an area where
Linux (and many of the Linux advocates) could really learn.

>From a user land perspective, only major Linux vendors or
organizations could enforce such a logo program, it would cost wads of
cash and it will really suck if you currently run the certification
process for Linux 2.5.102 for your driver and right before you're
done, 2.5.103 is released and you have to start all over again.

That's why most of the companies that _do_ provide drivers, provide
them for _one_ kernel release of some Linux distributions.

Heck, I was working with an IDS (won't tell you which one), which
shipped its security relevant kernel module _only_ for a truly well
known distribution with the stock kernel release which had remotely
exploitable holes.

While nVidia bashing is very popular on this list, this is one of the
few companies that, while distributing binary only drivers, try to
make an effort to keep their drivers reasonably up to date _and_ work
with most new kernel releases.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
