Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTKZNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbTKZNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:50:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:52887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264163AbTKZNuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:50:13 -0500
Date: Wed, 26 Nov 2003 05:56:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH][TRIVIAL] 2.6.0-test[9,10] Bug (typo) in smsc-ircc2.c
Message-Id: <20031126055655.47643e4d.akpm@osdl.org>
In-Reply-To: <20031126104746.GA31328@hazard.jcu.cz>
References: <20031126104746.GA31328@hazard.jcu.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Marek <linux@hazard.jcu.cz> wrote:
>
>  --- linux-2.6.0-test9/drivers/net/irda/smsc-ircc2.c	2003-10-25 20:43:57.000000000 +0200
>  +++ linux-2.6.0-test9-new/drivers/net/irda/smsc-ircc2.c	2003-11-05 23:07:37.000000000 +0100
>  @@ -524,7 +524,7 @@
>   
>   	return 0;
>    out3:
>  -	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
>  +	release_region(sir_base, SMSC_IRCC2_SIR_CHIP_IO_EXTENT);
>    out2:
>   	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
>    out1:
> 

yup, thanks.
