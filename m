Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTHSOJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTHSOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:09:48 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:2315 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S270487AbTHSNdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 09:33:06 -0400
Subject: Re: 2.6.0-test3-mm3
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
References: <20030819013834.1fa487dc.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1061299520.472.5.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 10:25:24 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Em Ter, 2003-08-19 às 05:38, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/

While compiling with gcc-3.2:

arch/i386/kernel/dmi_scan.c:167: warning: `dmi_dump_system'
defined but not used

 This warning happens because the only call to
dmi_dump_system() happens when CONFIG_ACPI_BOOT is defined,
but I _not_ have ACPI options enabled.

I'm getting the some warning in bk tree.

thanks,

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

