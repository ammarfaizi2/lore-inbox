Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272461AbTHIRYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272473AbTHIRYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:24:38 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55475 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S272461AbTHIRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:24:37 -0400
Date: Sat, 09 Aug 2003 11:27:51 -0600
From: Thomas Covello <pmjcovello@shaw.ca>
Subject: PROBLEM: drivers/block/paride/pd.c fails to compile at line 896 on	i686
To: linux-kernel@vger.kernel.org
Reply-to: pmjcovello@shaw.ca
Message-id: <1060450071.11078.6.camel@localhost.localdomain>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/block/paride/pd.c fails to compile at line 896 on an i686.
Here is a copy of the error messages I receive:

drivers/block/paride/pd.c: In function `pd_init':
drivers/block/paride/pd.c:896: warning: passing arg 1 of
`blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: warning: passing arg 2 of
`blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: too many arguments to function
`blk_init_queue'
make[2]: *** [drivers/block/paride/pd.o] Error 1
make[1]: *** [drivers/block/paride] Error 2
make: *** [drivers] Error 2

