Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSHDMpa>; Sun, 4 Aug 2002 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSHDMpa>; Sun, 4 Aug 2002 08:45:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45559 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316430AbSHDMp3>; Sun, 4 Aug 2002 08:45:29 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org, alien.ant@ntlworld.com
In-Reply-To: <20020804054239.62923.qmail@web9203.mail.yahoo.com>
References: <20020804054239.62923.qmail@web9203.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 15:07:17 +0100
Message-Id: <1028470037.14195.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 06:42, Alex Davis wrote:
> What is UDMA44????
> 
> 
> Aug  3 16:04:23 shaun kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Aug  3 16:04:23 shaun kernel: ide2 at 0x4400-0x4407,0x4412 on irq 23
> Aug  3 16:04:23 shaun kernel: hde: 60030432 sectors (30736 MB) w/2048KiB \
>                 Cache,CHS=59554/16/63, UDMA(66)
> Aug  3 16:04:23 shaun kernel: hdf: 90069840 sectors (46116 MB) w/1916KiB Cache, \
>                 CHS=89355/16/63, UDMA(44)

There are several actual speed steppings other than UDMA 33/66. The
33/66 are the top end for the control/cable. The drive may actually
choose a speed in between

