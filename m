Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUDFDEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 23:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDFDET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 23:04:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:25832 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S263604AbUDFDEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 23:04:12 -0400
Subject: New compiler warning: 2.6.4->2.6.5
From: John Cherry <cherry@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1081220649.13965.15.camel@lightning>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Apr 2004 20:04:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9 new compiler warnings between 2.6.4 and 2.6.5.

gcc: 3.2.2
arch: i386

drivers/acpi/events/evmisc.c:143: warning: too many arguments for format
drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards
qualifiers from pointer target type
drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers
from pointer target type
drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but
not used
drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
drivers/pcmcia/tcic.c:64: warning: `version' defined but not used
sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but
not used
sound/oss/wavfront.c:2498: warning: `errno' defined but not used

John



