Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288993AbSAUXy4>; Mon, 21 Jan 2002 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAUXyq>; Mon, 21 Jan 2002 18:54:46 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15352 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288993AbSAUXyc>; Mon, 21 Jan 2002 18:54:32 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1011622206.2978.3.camel@hal.savan.com> 
In-Reply-To: <1011622206.2978.3.camel@hal.savan.com>  <1011618928.2825.5.camel@hal.savan.com> <3C4C1A96.3504174D@loewe-komp.de> <1011620576.2978.0.camel@hal.savan.com> 
To: Erez Doron <erez@savan.com>
Cc: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: non volatile ram disk 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 23:54:22 +0000
Message-ID: <6107.1011657262@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


erez@savan.com said:
> i tried to map an mtd device to the second part of the ram, but got
> "partition is out of reach" 

The numbers you modified are the ones which say how to divide up the flash 
chip. Don't do that - you need to use the 'slram' driver and configure that 
to tell it which memory to use.

See http://lists.infradead.org/pipermail/linux-mtd/2002-January/003872.html

--
dwmw2


