Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSCZR5N>; Tue, 26 Mar 2002 12:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312616AbSCZR5D>; Tue, 26 Mar 2002 12:57:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312612AbSCZR44>; Tue, 26 Mar 2002 12:56:56 -0500
Subject: Re: readv() return and errno
To: jholly@cup.hp.com (Jim Hollenback)
Date: Tue, 26 Mar 2002 18:06:45 +0000 (GMT)
Cc: balbir_soni@yahoo.com (Balbir Singh), Andries.Brouwer@cwi.nl,
        jholly@cup.hp.com, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <1020326091332.ZM13559@fry.cup.hp.com> from "Jim Hollenback" at Mar 26, 2002 09:13:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pvLJ-0003aH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see much in the way of waffle words. If count is greater than
> MAX_IOVEC or zero you get EINVAL. I suppose your next argument is if

SuS is definitive not the man page. That page btw is woefully out of date

> If your going to rework the manpage, then drop a count of 0 as an error=
> ,
> otherwise fix the kernel with the trival patch.

The man page is buggy if anything is.
