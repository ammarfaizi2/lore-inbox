Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHXNH3>; Sat, 24 Aug 2002 09:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSHXNH3>; Sat, 24 Aug 2002 09:07:29 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:3028 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316089AbSHXNH3>; Sat, 24 Aug 2002 09:07:29 -0400
Message-ID: <3D6784F7.330E509C@wanadoo.fr>
Date: Sat, 24 Aug 2002 15:07:03 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
References: <Pine.LNX.4.44L.0208161340000.1430-100000@imladris.surriel.com>
		 <3D5D32D4.475C6719@wanadoo.fr> <1029611747.4647.3.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
>  "On Fri, 2002-08-16 at 18:13, Jean-Luc Coulon wrote:
> > At boot time, I get the messages :
> >
> > Aug 16 11:34:19 f5ibh kernel: ALI15X3: simplex device: DMA disabled
> > Aug 16 11:34:19 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
> > (BIOS)
> 
> Linux did the simplex device check. Your ALi controller only permits DMA
> on one of the devices at a time. What is attached to the ALi controller
> ? Also does 2.4.19 base enable DMA correctly ?
> 
> If so then my guess is there is a bug in the changing of the pci setup
> code in 2.4.20pre2-ac3, which shouldnt be hard to figure out

Sorry, I forgot,

2.4.19 enables DMA correctly, as well as 2.4.20-pre1

---------
Regards
	Jean-Luc
