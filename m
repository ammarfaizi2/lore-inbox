Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289561AbSAJR01>; Thu, 10 Jan 2002 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289562AbSAJR0I>; Thu, 10 Jan 2002 12:26:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289561AbSAJR0C>; Thu, 10 Jan 2002 12:26:02 -0500
Subject: Re: initramfs programs (was [RFC] klibc requirements)
To: cate@debian.org (Giacomo Catenazzi)
Date: Thu, 10 Jan 2002 17:37:24 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), alan@lxorguk.ukuu.org.uk (Alan Cox),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3C3DCBA7.4080802@debian.org> from "Giacomo Catenazzi" at Jan 10, 2002 06:13:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Oj8m-00050R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Surelly I will not maintain the DMI table!

Quite

> This is a call for help: how to write a table
> CPU - CONFIG_SYMBOL ?
> Now I use Vendor/Name/Family/Stepping/, but
> maybe with Vendor + flags (CPUID flags) the result
> will be more correct?

You need the family/model information to get the right optimisations. Its
often not that the instruction set is different but that the cpu
implementation is different that determines the choice. With a couple of 
exceptions cpu type is actually not too important and accidentally using
486 will make little difference
 
