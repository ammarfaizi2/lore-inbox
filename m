Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSLJPX7>; Tue, 10 Dec 2002 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLJPX7>; Tue, 10 Dec 2002 10:23:59 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:24255 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262317AbSLJPX6>; Tue, 10 Dec 2002 10:23:58 -0500
Subject: Re: 2.5.51 don't compil with dvb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb@linuxtv.org
In-Reply-To: <20021210150748.GB20411@ulima.unil.ch>
References: <20021210150748.GB20411@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 16:05:15 +0000
Message-Id: <1039536315.14175.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 15:07, Gregoire Favre wrote:
> drivers/built-in.o(.text+0x38655): In function `try_attach_device':
> : undefined reference to `MOD_CAN_QUERY'
> make: *** [vmlinux] Error 1
> 

Modules are still very broken in 2.5.51, its best to compile a system
which doesn't use modules or stay at an older kernel

