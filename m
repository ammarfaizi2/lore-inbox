Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSLARXI>; Sun, 1 Dec 2002 12:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLARXI>; Sun, 1 Dec 2002 12:23:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17052 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262214AbSLARXH>; Sun, 1 Dec 2002 12:23:07 -0500
Subject: Re: [patch]back ports ICH3M support into 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@hera.kernel.org>
In-Reply-To: <20021201130427.37a915bf.hugang@soulinfo.com>
References: <20021201130427.37a915bf.hugang@soulinfo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Dec 2002 18:03:25 +0000
Message-Id: <1038765805.30381.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 05:04, hugang wrote:
> hello 
>   Here is a back port patch for Intel ICH3M IDE 

2.4.20 already has the correct version of the fixes for partially
configured IDE devices. The code you are posting is old and in several
places wrong, hence it was removed.

2.4.20 will try and do a full pci device setup, then fall back to just
configuring BAR4.

Alan

