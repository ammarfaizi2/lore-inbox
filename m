Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUDFVqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbUDFVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:46:14 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:2828 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264045AbUDFVqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:46:12 -0400
Date: Tue, 6 Apr 2004 18:45:32 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New compiler warning: 2.6.4->2.6.5
Message-Id: <20040406184532.7e522647.lcapitulino@prefeitura.sp.gov.br>
In-Reply-To: <1081285188.2586.52.camel@cherrybomb.pdx.osdl.net>
References: <1081220649.13965.15.camel@lightning>
	<20040406141803.249bf06e.lcapitulino@prefeitura.sp.gov.br>
	<1081285188.2586.52.camel@cherrybomb.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 06 Apr 2004 13:59:48 -0700
John Cherry <cherry@osdl.org> escreveu:

| > | 9 new compiler warnings between 2.6.4 and 2.6.5.
| > | 
| > | gcc: 3.2.2
| > | arch: i386
| > | 
| > | drivers/acpi/events/evmisc.c:143: warning: too many arguments for format
| > | drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. -
| > | copy*user in cli"
| > | drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards
| > | qualifiers from pointer target type
| > | drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers
| > | from pointer target type
| > | drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but
| > | not used
| > | drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
| > | drivers/pcmcia/tcic.c:64: warning: `version' defined but not used
| > | sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but
| > | not used
| > | sound/oss/wavfront.c:2498: warning: `errno' defined but not used
| > 
| >  I fixed the ''errno''s warnings, the patches are in -mm.
| 
| Great.  Once they are merged, the errno warnings will be gone.
| 
| > 
| > PS: I think they are not new.
| 
| They were new relative to 2.6.4.  Check out the 2.6.4 build results:
| 
|  http://developer.osdl.org/cherry/compile/2.6/linux-2.6.4.results/

 Oh yes, they are not new in -mm, where the time goes fast. :-)

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>
