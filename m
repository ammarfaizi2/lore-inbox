Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSACMFH>; Thu, 3 Jan 2002 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286708AbSACME6>; Thu, 3 Jan 2002 07:04:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286263AbSACMEo>; Thu, 3 Jan 2002 07:04:44 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Thu, 3 Jan 2002 12:14:47 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), davej@suse.de (Dave Jones),
        Lionel.Bouton@free.fr (Lionel Bouton),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020103040924.B6936@thyrsus.com> from "Eric S. Raymond" at Jan 03, 2002 04:09:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M6lk-00087l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have my intentions backwards. What I'd like to be able to do is
> suppress ISA_SLOTS when there are detectably *no* ISA cards.  Unfortunately
> I have had it demonstrated that the DMI tables can give false negatives
> (false positives would not have been a showstopper).

Thats why I also suggested using lspci and looking for an ISA bridge.
If you have no PCI its probably ISA. If you have no PCI/ISA bridge its
very very unlikely to be ISA
