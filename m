Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVDFCXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVDFCXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVDFCXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:23:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:38110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262078AbVDFCWD (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:22:03 -0400
Date: Tue, 5 Apr 2005 19:21:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Derek Cheung" <derek.cheung@sympatico.ca>
Cc: greg@kroah.com, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-Id: <20050405192157.4b6de7bd.akpm@osdl.org>
In-Reply-To: <003801c53a4e$e5df3d80$1501a8c0@Mainframe>
References: <20050405044836.GA17336@kroah.com>
	<003801c53a4e$e5df3d80$1501a8c0@Mainframe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Derek Cheung" <derek.cheung@sympatico.ca> wrote:
>
>  Below please find the patch file I "diff" against Linux 2.6.11.6. It
>  contains the I2C adaptor for ColdFire 5282 CPU. Since most ColdFire CPU
>  shares the same I2C register set, the code can be easily adopted for
>  other ColdFire CPUs for I2C operations.
> 
>  I have tested the code on a ColdFire 5282Lite CPU board
>  (http://www.axman.com/Pages/cml-5282LITE.html) running uClinux 2.6.9
>  with LM75 and DS1621 temperature sensor chips. As advised by David
>  McCullough, the code will be incorporated in the next uClinux release.
> 
>  The patch contains:
> 
>  linux/drivers/i2c/busses
>   		i2c-mcf5282.c (new file)
>   		i2c-mcf5282.h (new file)
>   		Kconfig (modified)
>   		Makefile (modified)
>   
>  linux/include/asm-m68knommu
>   		m528xsim.h (modified)
> 
>  Please let me know if you have any questions.

The patch was very wordwrapped by your email client.  Please fix that up
(first email the patch to yourself and test that the result still applies OK) or
resend as an email attachment.

Thanks.
