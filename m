Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSEGOZh>; Tue, 7 May 2002 10:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315739AbSEGOZg>; Tue, 7 May 2002 10:25:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38160 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315734AbSEGOZe>; Tue, 7 May 2002 10:25:34 -0400
Subject: Re: [PATCH 2.5.13 IDE 54
To: paulus@samba.org (Paul Mackerras)
Date: Tue, 7 May 2002 15:07:16 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <15575.52723.240506.668782@argo.ozlabs.ibm.com> from "Paul Mackerras" at May 07, 2002 10:52:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1755ca-0007Xt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The comment above udma_enable seems to indicate that you think it
> should be ifdef'd per-architecture.  That won't work for us (besides
> being ugly), because we can have two ATA host adaptors in the one
> machine that need to be programmed quite differently.  Consider for
> instance a powermac with the built-in IDE interface (which would use
> the ide-pmac.c code) and a plug-in PCI IDE card, for which the
> udma_enable code is presumably correct.

The same will be true for the PC very soon. In fact in a few cases
it already is
