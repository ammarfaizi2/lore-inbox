Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbSJGTqU>; Mon, 7 Oct 2002 15:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbSJGTqT>; Mon, 7 Oct 2002 15:46:19 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:58355 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262654AbSJGTqR>; Mon, 7 Oct 2002 15:46:17 -0400
Subject: Re: New PCI Device Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Jennings <jennings@red-river.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1034020706.26549.7.camel@irongate.swansea.linux.org.uk>
References: <NFBBJBMDCLFFHHFEAKNAMEEHCBAA.jennings@red-river.com> 
	<1034020706.26549.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 21:01:40 +0100
Message-Id: <1034020900.26505.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 20:58, Alan Cox wrote:
> 
> 	addr = ioremap(io_base_start, len);
>         databuf = read(addr + 0x590);
> 

Should be readb (the functions are readb / readw / readl / writeb /
writew / writel)

