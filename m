Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLQMFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 07:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLQMFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 07:05:51 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:18955 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264414AbTLQMFu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 07:05:50 -0500
Subject: Re: UP build broken (Re: 2.6.0-test11-mm1)
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Dagfinn Ilmari =?ISO-8859-1?Q?Manns=E5ker?= <ilmari@ilmari.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <d8j1xr34py6.fsf@wirth.ping.uio.no>
References: <20031217014350.028460b2.akpm@osdl.org>
	 <d8j1xr34py6.fsf@wirth.ping.uio.no>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1071662138.27233.5.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Dec 2003 09:55:39 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2003-12-17 às 09:57, Dagfinn Ilmari Mannsåker escreveu:
> Hi
> 
> Without CONFIG_SMP (regardless of CONFIG_X86_UP_(IO)APIC) I get the
> following build error:
> 
>   CC      arch/i386/kernel/cpu/intel.o
> In file included from arch/i386/kernel/cpu/intel.c:14:
> include/asm-i386/mach-default/mach_apic.h:8: error: syntax error before "target_cpus"

I'm getting the some thing. I think the file
asm-generic/cpu_mask_const_value.h is not included (this file have the
definitions).

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

