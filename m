Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272236AbTHIB0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272167AbTHIB0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:26:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:34774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272153AbTHIB0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:26:19 -0400
Date: Fri, 8 Aug 2003 18:31:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
cc: davidm@napali.hpl.hp.com, <Matt_Domsch@Dell.com>, <torvalds@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <matthew.e.tolentino@intel.com>
Subject: Re: [patch] move efivars to drivers/efi
In-Reply-To: <200308090104.h7914sKd026665@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.44.0308081829530.959-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch against 2.6.0-test2 does several things:
> 
> 1.  Creates a new directory (drivers/efi) into which I propose current and future drivers that interact with EFI firmware be placed.  This enables architectures that employ EFI compliant firmware to use the same drivers and avoid the maintenance hassle of multiple copies.  
> 
> 2.  Move the current EFI variable services driver (efivars) found in arch/ia64/kernel into drivers/efi.
> 
> Note that I've added similar config options for x86 in a separate patch that also enables EFI awareness that I'll resend to the list shortly.  
> 
> Thoughts?  Comments?

Yes - have you considered doing a sysfs interface instead of procfs? :) 


	-pat

