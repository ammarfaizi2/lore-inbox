Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSIALlE>; Sun, 1 Sep 2002 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSIALlE>; Sun, 1 Sep 2002 07:41:04 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:34039
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316695AbSIALlD>; Sun, 1 Sep 2002 07:41:03 -0400
Subject: Re: [info] 2.4.20-pre5-ac1 still have the DMA problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D71D84B.61C15376@wanadoo.fr>
References: <3D71D84B.61C15376@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 01 Sep 2002 12:46:25 +0100
Message-Id: <1030880785.3490.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 10:05, Jean-Luc Coulon wrote:
> Aug 31 11:21:07 f5ibh kernel: ALI15X3: chipset revision 193
> Aug 31 11:21:07 f5ibh kernel: ALI15X3: not 100%% native mode: will probe
> irqs later
> Aug 31 11:21:07 f5ibh kernel: ALI15X3: simplex device with no drives:
> DMA disabled
> Aug 31 11:21:07 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
> (BIOS)
> Aug 31 11:21:07 f5ibh kernel: ALI15X3: simplex device with no drives:
> DMA disabled
> Aug 31 11:21:07 f5ibh kernel: ide1: ALI15X3 Bus-Master DMA disabled
> (BIOS)

I expect it to continue to turn DMA off on all parts of simplex devices
for a while yet. Correctness first

