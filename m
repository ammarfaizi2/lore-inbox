Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbTCGLRf>; Fri, 7 Mar 2003 06:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTCGLRf>; Fri, 7 Mar 2003 06:17:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14761
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261528AbTCGLRe>; Fri, 7 Mar 2003 06:17:34 -0500
Subject: Re: [PATCH] remove spare cast
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0303071201510.13981-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303071201510.13981-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047040421.20794.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:33:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 11:03, Geert Uytterhoeven wrote:
> 
> This reintroduces the following warning (with gcc-2.95.2 and gcc-3.2)
> 
> | drivers/ide/ide-lib.c:174: warning: comparison of distinct pointer types
> | lacks a cast
> 
> which the cast was supposed to kill.

I know. Right now I don't care because I'm slowly turning all the u8 stuff
back into ints which is actually less code and faster on most processors.

