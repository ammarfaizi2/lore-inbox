Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSG2Kmi>; Mon, 29 Jul 2002 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSG2Kmi>; Mon, 29 Jul 2002 06:42:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19447 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314680AbSG2Kmg>; Mon, 29 Jul 2002 06:42:36 -0400
Subject: Re: Linux 2.4.19-rc1-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <3D4478DA.53CF8999@daimi.au.dk>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
	<3D340775.7F7AAFB9@daimi.au.dk> <3D35A554.5E7BBF59@daimi.au.dk> 
	<3D4478DA.53CF8999@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 13:00:55 +0100
Message-Id: <1027944055.842.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 00:06, Kasper Dupont wrote:
roc;
> #ifdef CONFIG_IDEDMA_AUTO
>                 if (!noautodma)
>                         hwif->autodma = 1;
> #endif /* CONFIG_IDEDMA_AUTO */
>         }
> #endif /* CONFIG_BLK_DEV_IDEDMA */
> 
> CONFIG_IDEDMA_AUTO will always be turned off by
> make *config, but if I enable this option by
> changing .config with a texteditor DMA actually
> works.
> 

I'll take a look. That looks like an escaped piece of history

