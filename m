Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRIVP5E>; Sat, 22 Sep 2001 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRIVP4x>; Sat, 22 Sep 2001 11:56:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37388 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271712AbRIVP4l>; Sat, 22 Sep 2001 11:56:41 -0400
Subject: Re: [PATCH] 2.4.10-pre13: ATM drivers cause panic
To: tip@prs.de
Date: Sat, 22 Sep 2001 17:01:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        laughing@shared-source.org
In-Reply-To: <3BAC93D4.65E17AA6@internetwork-ag.de> from "Till Immanuel Patzschke" at Sep 22, 2001 03:36:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpDk-0003Xu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways, please find a (quick) patch below. It would be great if this patch or
> any other similar could make it into the next release!
> Thanks,

That patch cannot possibly be correct. alloc_atm_dev sleeps
