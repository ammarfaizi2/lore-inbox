Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263076AbTCWOUL>; Sun, 23 Mar 2003 09:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbTCWOUL>; Sun, 23 Mar 2003 09:20:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44706
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263076AbTCWOUJ>; Sun, 23 Mar 2003 09:20:09 -0500
Subject: Re: [PATCH] parallel port
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048434223.10712.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:43:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 03:21, Linus Torvalds wrote:
> This one causes 
> 
> 	drivers/parport/parport_pc.c:2273: warning: implicit declaration of function `rename_region'
> 	drivers/built-in.o(.text+0x77a8c): In function `parport_pc_probe_port':
> 	: undefined reference to `rename_region'
> 
> for me. I think I complained about that once before already. Tssk, tssk.

Argh, my fault. The original patch I merged does indeed have rename_region as well but
I missed the requirement

