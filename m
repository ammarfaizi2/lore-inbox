Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVGMQyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVGMQyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:53:50 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:64244 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261244AbVGMQvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:51:05 -0400
Subject: [PATCH 0/19] Kconfig I18N completion
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 18:50:56 +0200
Message-Id: <1121273456.2975.3.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patches complete the "Kconfig I18N support" patch by
Arnaldo. 

The following parts are internationalised:
- Kconfig prompt, help, comment and menu texts
- full visible configuration interfaces
- error messages if the user can correct the errors (ex. saving config
file)
- answering (Y/M/N)
- option's value if it is a choice (viewing only)

Without I18N support:
- symbol names (CONFIG_xxx)
- Kconfig parsing errors in LKC
- lxdialog's errors
- content of the config file
- disabled debug messages in the source code

Some incomplete language files are downloadable from the
http://sourceforge.net/projects/tlktp/ page for testing (langpack).

Currently available:
- Italian (98%)
- Hungarian (67%)
- French (37%)
- Catalan (10%)
- Russian (5%)

All patches are tested without any problems.

Please apply the patches.

Regards,
Egry Gabor


