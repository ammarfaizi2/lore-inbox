Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTBLQYt>; Wed, 12 Feb 2003 11:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTBLQYt>; Wed, 12 Feb 2003 11:24:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53120
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267353AbTBLQYs>; Wed, 12 Feb 2003 11:24:48 -0500
Subject: Re: linux-2.5.60 against phoebe-kernel-2.4.20-2.41
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alvaro  Barbosa G." <alvaro.barbosa-g@ntlworld.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302121529.38808.alvaro.barbosa-g@ntlworld.com>
References: <200302121529.38808.alvaro.barbosa-g@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045071284.3502.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Feb 2003 17:34:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 15:29, Alvaro Barbosa G. wrote:
> Hi,
> 
> Silly question, is it possible to compile linux-2.5.60 against phoebe 
> kernel-2.4.20-2.41?
> When creating bzImage, gets:
> 
> make bzImage 2>bzI_err
> ld:arch/i386/kernel/.tmp_time.ver:1: parse error
> make[1]: *** [arch/i386/kernel/time.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 

2.5.60 seems to have a buggy sed script - search the archive and you'll find
a patch has been posted which seems to work

