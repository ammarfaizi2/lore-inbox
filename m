Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268426AbTGIRIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268422AbTGIRIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:08:00 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:19592 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S268426AbTGIRHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:07:41 -0400
Subject: 2.4.22-pre4+ build error with CONFIG_QFMT_V2=y.
From: Steven Cole <elenstev@mesatop.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1057770969.8754.38.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 09 Jul 2003 11:16:10 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_QFMT_V2=y, I get the following build error:

make[2]: *** No rule to make target `quota_v2.o', needed by `fs.o'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/home/steven/BK/testing-2.4/fs'
make[1]: *** [first_rule] Error 2

[steven@spc5 testing-2.4]$ grep ^CONFIG_Q .config
CONFIG_QUOTA=y
CONFIG_QFMT_V2=y

Kernel is 2.4.22-pre4+ pulled one hour ago with:
bk pull bk://linux.bkbits.net/linux-2.4

This builds fine with only CONFIG_QUOTA=y.

Steven

