Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGLS4H>; Fri, 12 Jul 2002 14:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGLS4G>; Fri, 12 Jul 2002 14:56:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50695 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316823AbSGLS4F>; Fri, 12 Jul 2002 14:56:05 -0400
Subject: Re: ATAPI + cdwriter problem
To: as@sci.fi (Anssi Saari)
Date: Fri, 12 Jul 2002 20:22:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020712185522.GA12751@sci.fi> from "Anssi Saari" at Jul 12, 2002 09:55:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T5zr-0003e6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Didn't fix mine either. First CD I tried to write on a pdc20265, I just
> got these two messages in kern.log:
> 
> ide-scsi: CoD != 0 in idescsi_pc_intr
> hdg: ATAPI reset complete

I get this on underruns on my CMD controller too. I've yet to have time to
look into that or the ide-scsi oops reading a dud disk (duplicated here)
