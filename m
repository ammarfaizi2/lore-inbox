Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264011AbUDFVDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDFVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:03:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:38535 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264020AbUDFVBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:01:35 -0400
Subject: Re: New compiler warning: 2.6.4->2.6.5
From: John Cherry <cherry@osdl.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040406141803.249bf06e.lcapitulino@prefeitura.sp.gov.br>
References: <1081220649.13965.15.camel@lightning>
	 <20040406141803.249bf06e.lcapitulino@prefeitura.sp.gov.br>
Content-Type: text/plain
Message-Id: <1081285188.2586.52.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 13:59:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 10:18, Luiz Fernando N. Capitulino wrote:
> Hi John,
> 
> Em 05 Apr 2004 20:04:09 -0700
> John Cherry <cherry@osdl.org> escreveu:
> 
> | 9 new compiler warnings between 2.6.4 and 2.6.5.
> | 
> | gcc: 3.2.2
> | arch: i386
> | 
> | drivers/acpi/events/evmisc.c:143: warning: too many arguments for format
> | drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. -
> | copy*user in cli"
> | drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards
> | qualifiers from pointer target type
> | drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers
> | from pointer target type
> | drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but
> | not used
> | drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
> | drivers/pcmcia/tcic.c:64: warning: `version' defined but not used
> | sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but
> | not used
> | sound/oss/wavfront.c:2498: warning: `errno' defined but not used
> 
>  I fixed the ''errno''s warnings, the patches are in -mm.

Great.  Once they are merged, the errno warnings will be gone.

> 
> PS: I think they are not new.

They were new relative to 2.6.4.  Check out the 2.6.4 build results:

 http://developer.osdl.org/cherry/compile/2.6/linux-2.6.4.results/

John


