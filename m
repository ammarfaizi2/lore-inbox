Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbSKHQkj>; Fri, 8 Nov 2002 11:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266798AbSKHQkj>; Fri, 8 Nov 2002 11:40:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:21660 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266796AbSKHQkj>; Fri, 8 Nov 2002 11:40:39 -0500
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021107164009.GL1737@tmathiasen>
References: <20021107164009.GL1737@tmathiasen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:10:38 +0000
Message-Id: <1036775438.16898.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 16:40, Torben Mathiasen wrote:
> Linus,
> 
> Please accept the attached for 2.5.46.
> 
> It introduces a new boot parameter (eg. ide0=biostimings) that forces the
> IDE driver to honour BIOS DMA/PIO timings. Sometimes the BIOS has a better
> overview of how the IDE devices are connected/setup and some chipsets doesn't
> support >ata66 speed detection.
> 
> The patch has been tested for quite a while on both PIIX and serverworks.

Linus please drop this patch for now. Its not been tested on enough
controllers, its making things unneccessarily ugly and its also just
going to make updates hard.

