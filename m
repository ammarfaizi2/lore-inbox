Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283804AbRLEIn5>; Wed, 5 Dec 2001 03:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283807AbRLEInw>; Wed, 5 Dec 2001 03:43:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11533 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283804AbRLEIno>; Wed, 5 Dec 2001 03:43:44 -0500
Subject: Re: Oops in d_lookup (dcache.c)
To: mathias.teikari@q-free.com (Mathias Teikari)
Date: Wed, 5 Dec 2001 08:49:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mathias.teikari@q-free.com (mathias Teikari)
In-Reply-To: <3C0DC97D.8010503@q-free.com> from "Mathias Teikari" at Dec 05, 2001 06:15:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BXkK-0005Kf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Red Hat 7.1 (kernel 2.4.2-2) with a two physical disks in Raid 1
> configuration.

Firstly get the RH 7.1/7.2 errata kernel. That trace doesn't give too much
info (yes it oopses in the dcache but who broke the dcache before that...)
So much has been fixed between the RH and generic 2.4.2 and 2.4.9 that its
not really worth thinking hard about 
