Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270973AbTGPRzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271016AbTGPRxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:53:51 -0400
Received: from [200.230.190.107] ([200.230.190.107]:45061 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S271002AbTGPRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:53:35 -0400
Subject: [BUG] 2.6-osdl1 compiler error.
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Governo Eletronico - SP
Message-Id: <1058379123.398.4.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 16 Jul 2003 15:12:04 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

 While trying to compile the 2.6-osdl1 with the 
''performance-monitoring'' I'm getting this:

CC      drivers/perfctr/init.o
drivers/perfctr/init.c:19: version.h: No such file or directory
drivers/perfctr/init.c:36: `VERSION' undeclared here (not in a
function)
drivers/perfctr/init.c:36: initializer element is not constant
drivers/perfctr/init.c:36: (near initialization for
`perfctr_info.driver_version')
drivers/perfctr/init.c:36: parse error before string constant
make[2]: ** [drivers/perfctr/init.o] Error 1
make[1]: ** [drivers/perfctr] Error 2
make: ** [drivers] Error 2


-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

