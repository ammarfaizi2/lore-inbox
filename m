Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWJ1EdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWJ1EdM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWJ1EdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:33:12 -0400
Received: from gw.goop.org ([64.81.55.164]:14824 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751798AbWJ1EdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:33:10 -0400
Message-ID: <4542DD84.3070006@goop.org>
Date: Fri, 27 Oct 2006 21:33:08 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, Rusty Russell <rusty@rustcorp.com.au>,
       virtualization <virtualization@lists.osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
 address space
References: <1161920325.17807.29.camel@localhost.localdomain>	<1161920535.17807.33.camel@localhost.localdomain>	<20061027113001.GB8095@elf.ucw.cz>	<45427ABD.6070407@goop.org> <20061027144157.f23fcf89.akpm@osdl.org>
In-Reply-To: <20061027144157.f23fcf89.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It'd be better to use include/linux/uaccess.h:probe_kernel_address() for
> this operation.
>   
Ah, yes, that was the precedent I was thinking of,  but I guess it would 
be better to just use it directly.  It's a relatively new interface, 
isn't it?

    J
