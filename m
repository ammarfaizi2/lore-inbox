Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUJMFVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUJMFVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUJMFVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:21:49 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:6947 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268340AbUJMFVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:21:46 -0400
Message-ID: <1a50bd370410122221ebb3796@mail.gmail.com>
Date: Wed, 13 Oct 2004 10:51:46 +0530
From: Ricky lloyd <ricky.lloyd@gmail.com>
Reply-To: Ricky lloyd <ricky.lloyd@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Build problems with APM/Subarch type
Cc: Raj <inguva@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <416CB8FC.9020503@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b2fa632f04101204385c09459f@mail.gmail.com>
	 <416CB8FC.9020503@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Did all the configuration properly, except that i fumbled on the keyboard and
> > the option 'Subarchitecture Type' somehow got set to
> > '(SGI 320/540 Visual Workstation)'.
> 
> Using an editor or make *config?  which *config?

make menuconfig.

> 
> > The build failed with an error 'Undefined reference to machine_real_restart'
> 
> Yep, I see that also.
> 
> > It seems that , unless Subarch is PC-Compatible ( CONFIG_PC ) ,
> > CONFIG_X86_BIOS_REBOOT will not be set and thusly, reboot.c would not be
> > compiled.
> >
> > ( yeah, i know messing around with configs is suicidal, but.... )
> >
> > Can this be fixed ?? At the very least, hide APM options #if !(CONFIG_PC) ??
> 
> Do you/we/maintainer know that APM is not applicable to all of the
> other PC sub-arches?
> 
afaics, i found 'apm.c' only in arch/i386/kernel and arch/arm/kernel.
does that really
confirm that apm would not be applicable for other archs ?? 

> I agree that it should be fixed, one way or another.
> --
> ~Randy
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
-> Ricky
