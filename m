Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSAIQIS>; Wed, 9 Jan 2002 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287756AbSAIQIH>; Wed, 9 Jan 2002 11:08:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33806 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287720AbSAIQHx>; Wed, 9 Jan 2002 11:07:53 -0500
Subject: Re: [PATCH][RFCA] Sound: Avance Logic codecs addition
To: salvador@inti.gov.ar
Date: Wed, 9 Jan 2002 16:18:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (Linux-kernel),
        ollie@sis.com.tw (Ollie Lho)
In-Reply-To: <3C3C6966.4679872E@inti.gov.ar> from "salvador" at Jan 09, 2002 01:01:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OLR5-0001Zt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch not only adds the entries but also changes the structure a little
> bit. That's needed because according to the datasheets the lower 4 bits are
> reserved for the revision number (0000==rev A). In fact the chip I have
> returns 6 as revision number. For this reason I added a field to indicate a

That has wanted doing for a very long time. I believe some bits are
fab/version bits in the crystal ones too and could also be simplified
