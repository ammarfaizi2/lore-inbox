Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJYRNy>; Thu, 25 Oct 2001 13:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYRNo>; Thu, 25 Oct 2001 13:13:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273904AbRJYRNf>; Thu, 25 Oct 2001 13:13:35 -0400
Subject: Re: 2.4.13-pre5-aa1 O_DIRECT drastic HIGHMEM performance hit
To: Mjustice@boxxtech.com (Marvin Justice)
Date: Thu, 25 Oct 2001 18:20:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B6867E6CB09B24385A73719A50C7C9A01797E@athena.boxxtech.com> from "Marvin Justice" at Oct 25, 2001 11:57:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15woBH-0005U4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are we stuck with a low mem configuration or are there workarounds that
> would allow us to stick with the initial 2GB of RAM and still get ~200
> MB/sec.

Jens has patches for doing direct DMA I/O from highmem pages. That should
basically nullify that hit. Doing that mainstream is a 2.5 thing really
