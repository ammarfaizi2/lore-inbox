Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271864AbTGRP75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271835AbTGRP6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:58:44 -0400
Received: from fusilli.4news.com.br ([200.246.225.77]:51852 "EHLO
	fusilli.alltv.com.br") by vger.kernel.org with ESMTP
	id S271838AbTGRP6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:58:25 -0400
Subject: Re: 2.5.72 insmod question
From: Cesar Suga <sartre@linuxbr.com>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
Content-Type: text/plain
Message-Id: <1058522370.253.28.camel@sartre.alltv.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jul 2003 06:59:31 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 21:35, yiding_wang@agilent.com wrote:

	Hello,

	Install the 'module-init-tools' package, from:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/

	This is required for the new series of kernels, starting with 2.5.50 (I
think), 2.5.72 certainly requires it.

	Cheers,
	Cesar Suga <sartre@linuxbr.com>

> I completed a fibre channel driver change to support for 2.5.72 (suppose to be 2.6 compatible) and compiled it OK.  When trying load the driver with "insmod", it complains with the message "insmod: QM_MODULES: Function not implemented".
> 
> I tried kernel built module qla1280.o and got the same result.  It seems the insmod utility in my system is not compatible with new 2.5.72 built module.
> 
> I have 2.4.20-8 kernel installed first and driver loads and runs fine.  Later added 2.5.72 kernel and booted with its bzImage works fine too.  However, the insmod utility I am using to load new driver was from 2.4.20-8 which has system_query_module() being called.  I checked Doc. and source code for 2.5.72 and could not find same function call in module.c
> 
> Some web documents mentioned that the module installation is changed from 2.4.x to 2.5.x.  So far I am still looking for the solution and hope someone can help me on the issue.
> 
> I am compiling the driver out side of kernel source tree but using kernel environmental variables for compatibility.
> 
> Regards,
> 
> Eddie
> 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

