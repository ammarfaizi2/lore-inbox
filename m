Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbULZPn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbULZPn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbULZPmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:42:45 -0500
Received: from fsmlabs.com ([168.103.115.128]:43959 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261686AbULZPk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:40:28 -0500
Date: Sun, 26 Dec 2004 08:40:16 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Nelson <james4765@verizon.net>
cc: ultralinux@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: remove x86-specific SMP reference in Kconfig
In-Reply-To: <20041226134715.11731.39190.49206@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412260839020.17702@montezuma.fsmlabs.com>
References: <20041226134715.11731.39190.49206@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, James Nelson wrote:

> Remove inapplicable references to x86 SMP configuration in arch/sparc64/Kconfig.
> 
>  	  People using multiprocessor machines who say Y here should also say
>  	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
>  	  Management" code will be disabled if you say Y here.

APM isn't applicable to sparc64 either.

>  	  See also the <file:Documentation/smp.txt>,
> -	  <file:Documentation/i386/IO-APIC.txt>,
>  	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at

Nor is the nmi watchdog.

