Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266269AbTGJDKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268829AbTGJDKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:10:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22236 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266269AbTGJDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:10:32 -0400
Date: Thu, 10 Jul 2003 00:22:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Grover <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.4.22-pre4_x440-acpi-fix_A0
In-Reply-To: <1057799280.27380.248.camel@w-jstultz2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.55L.0307100019460.6316@freak.distro.conectiva>
References: <1057799280.27380.248.camel@w-jstultz2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jul 2003, john stultz wrote:

> Marcelo, Andrew, All,
>
> 	Due to the new ACPI code, when booting in full ACPI mode, we do not go
> through the mps tables, thus we do not execute the summit detection code
> required for booting an x440.
>
> This patch insures that when booting in full ACPI mode we check to see
> if we're running on a summit based system and enable clustered apic
> mode. Without this patch the x440s hang while booting in full ACPI mode.
>
> Thanks to James Cleverdon for the original version of this patch.
>
> Please apply,


I just applied it John, it will be in bk soon.

But cant that be done in a cleaner way?

The acpi_madt_oem_check() call and implementation are the cleaner way of
doing this?

