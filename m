Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290534AbSBFNzd>; Wed, 6 Feb 2002 08:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290536AbSBFNzX>; Wed, 6 Feb 2002 08:55:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290527AbSBFNzI>; Wed, 6 Feb 2002 08:55:08 -0500
Subject: Re: [PATCH] NSC Geode Companion chip workaround
To: miura@da-cha.org (Hiroshi MIURA)
Date: Wed, 6 Feb 2002 14:08:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020206022016.735C7118231@triton2> from "Hiroshi MIURA" at Feb 06, 2002 11:20:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YSkP-0005CT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in this patch, this code is activate only if you defines CONFIG_CS5520.
> I've tryed several month with this patch, It seems good for me.
>     trial machine: Casio CASSIOPEIA FIVA 101 and Fiva 103.
>                    MediaGX 200MHz and NSC Geode 300MHz.

Interesting. That would explain a lot. Unfortunately when I first reported
that problem and disabled the TSC Cyrix actually refused to believe the
problem existed.

With the below it looks fixable

(The CONFIG_CS5520 we can replace I think with a check for the PCI device)

