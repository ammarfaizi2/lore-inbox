Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUJMF1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUJMF1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUJMF1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:27:12 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:56434 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268357AbUJMF1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:27:04 -0400
Message-ID: <b2fa632f041012222745006916@mail.gmail.com>
Date: Wed, 13 Oct 2004 10:57:00 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Build problems with APM/Subarch type
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <416CB8FC.9020503@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b2fa632f04101204385c09459f@mail.gmail.com>
	 <416CB8FC.9020503@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using an editor or make *config?  which *config?
> 
xconfig

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
> I agree that it should be fixed, one way or another.

i am not aware much about the apm dependencies. maintainers might answer 
this more correctly. 

-- 
######
raj
######
