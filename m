Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRI0XIx>; Thu, 27 Sep 2001 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274065AbRI0XIn>; Thu, 27 Sep 2001 19:08:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43794 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274064AbRI0XId>; Thu, 27 Sep 2001 19:08:33 -0400
Subject: Re: OOM killer
To: juhl@eisenstein.dk (Jesper Juhl)
Date: Fri, 28 Sep 2001 00:13:35 +0100 (BST)
Cc: linux-kernel@alex.org.uk (Alex Bligh - linux-kernel),
        jdthood@yahoo.co.uk (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <3BB21918.AD6761FC@eisenstein.dk> from "Jesper Juhl" at Sep 26, 2001 08:06:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mkLX-0005S3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > shed:~# echo 0 >/proc/sys/vm/overcommit_memory
> > shed:~# cat /proc/sys/vm/overcommit_memory
> > 0
> 
> ahh, I see. Well, you live and learn ;)
> 
> I think I've got to do my research better before writing mails to lkml.

In part.

The option you want is '2' which isnt implemented 8)

0	-	I don't care
1	-	Use heuristics to guesstimate avoiding overcommit

