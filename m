Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVEMTop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVEMTop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVEMTmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:42:53 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:56224 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262506AbVEMTjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:39:49 -0400
Date: Fri, 13 May 2005 21:40:16 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050513194016.GA12655@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: Re: 2.6.12-rc4-mm1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does not compile for CONFIG_ACPI=n & CONFIG_X86_HT=y (thus CONFIG_ACPI_BOOT=y):

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:97: error: syntax error before "acpi_sci_flags"
arch/i386/kernel/setup.c:97: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:97: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:812: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:815: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:818: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:821: error: request for member `polarity' in something not a structure or union
make[1]: *** [arch/i386/kernel/setup.o] Error 1


Johannes
