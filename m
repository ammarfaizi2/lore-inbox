Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSBMUbS>; Wed, 13 Feb 2002 15:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSBMUbI>; Wed, 13 Feb 2002 15:31:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288870AbSBMUbC>; Wed, 13 Feb 2002 15:31:02 -0500
Subject: Re: LDT_ENTRIES in ldt.h: why 8192?
To: jakub@redhat.com
Date: Wed, 13 Feb 2002 20:44:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020213152756.F21624@devserv.devel.redhat.com> from "Jakub Jelinek" at Feb 13, 2002 03:27:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16b6Gp-0006Mq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> E.g. linuxthreads can eat up to 1024 LDT entries, but that's not very common.
> IMHO there should be a single entry LDT, the emulation 5 entry LDT (current
> default_ldt), 512 entries LDT (page) and then the full blown 8192 entries
> LDT variants. Will post a patch once I finish it.

Manfred already posted a patch that also uses kmalloc not vmalloc which 
improves things no end. Why not use his patch ?
