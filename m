Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSLBPEt>; Mon, 2 Dec 2002 10:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSLBPEt>; Mon, 2 Dec 2002 10:04:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10654 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262708AbSLBPEs>; Mon, 2 Dec 2002 10:04:48 -0500
Subject: Re: bug in alim15x3(kernel 2.4.20)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Elie =?ISO-8859-1?Q?Dadd=E9=22?= <ginolb89@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY1-F174ETQtU6Go6x000061ef@hotmail.com>
References: <BAY1-F174ETQtU6Go6x000061ef@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 15:45:52 +0000
Message-Id: <1038843953.1020.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 13:25, Elie =?ISO-8859-1?Q?Dadd=E9=22?=
@lxorguk.ukuu.org.uk wrote:
> /dev/hda:
> 
> #here the kernel hang up when i use alim15x3  driver to enable dma
> ManOwaRR kernel: hdc: timeout waiting for DMA
> ManOwaRR kernel: hdc: irq timeout: status=0x58 { DriveReady SeekComplete 
> DataRequest }

Your timeout/reset is on hdc, not hda but you provide only hda info. 

