Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSECNkP>; Fri, 3 May 2002 09:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSECNkN>; Fri, 3 May 2002 09:40:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9737 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312991AbSECNkL>; Fri, 3 May 2002 09:40:11 -0400
Subject: Re: [2.4 patch] CONFIG_AGP_HP_ZX1 should only be available on ia64
To: bunk@fs.tum.de (Adrian Bunk)
Date: Fri, 3 May 2002 14:58:38 +0100 (BST)
Cc: bjorn_helgaas@hp.com, marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0205030848230.2605-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at May 03, 2002 08:52:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173da2-0006NW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> available on ia64 but it was selectable on i386. The problem seems to be
> that IIRC the dependency on a symbol in dep_bool doesn't work if the
> symbol is neither set or unset.

Indeed 

> The following patch should fix this (tested only on i386):

Already in -ac for a couple of patches - so it seems to work

Alan
