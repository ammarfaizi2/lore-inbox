Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHXMxk>; Sat, 24 Aug 2002 08:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSHXMxk>; Sat, 24 Aug 2002 08:53:40 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:6278 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316088AbSHXMxk>; Sat, 24 Aug 2002 08:53:40 -0400
Message-ID: <3D6781AB.526434F6@wanadoo.fr>
Date: Sat, 24 Aug 2002 14:52:59 +0200
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

sorry for the late answer, I was not @home for one week.

Attached to my ide ports are :
on the primary channel : 1 ide disk,  QUANTUM FIREBALLP LM30
                         1 ide disk,  ST3491A

on the secondary channel : 1 cdrom reader, CREATIVECD3621E
                           1 cdrom burner, GoldStar CD-RW CED-8083B

The second HDD is not DMA

-------
regards
	Jean-Luc
