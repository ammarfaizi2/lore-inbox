Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTJXS7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJXS7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:59:43 -0400
Received: from [194.185.97.41] ([194.185.97.41]:62219 "EHLO
	gsp04-c21d2.vodafone.it") by vger.kernel.org with ESMTP
	id S262468AbTJXS7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:59:42 -0400
From: Giuseppe <gdm84@vodafone.it>
To: linux-kernel@vger.kernel.org
Subject: can't compile udf
Date: Fri, 24 Oct 2003 12:56:42 +0000
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310241256.42888.gdm84@vodafone.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't compile udf filesystem support with 2.6-test8 (i compiled it in 
test6); this is what i get:

CC      fs/udf/super.o
fs/udf/super.c: In function `udf_parse_options':
fs/udf/super.c:327: `opt' undeclared (first use in this function)
fs/udf/super.c:327: (Each undeclared identifier is reported only once
fs/udf/super.c:327: for each function it appears in.)
fs/udf/super.c:332: `val' undeclared (first use in this function)
fs/udf/super.c:310: warning: unused variable `p'
fs/udf/super.c:311: warning: unused variable `option'
fs/udf/udf_i.h: At top level:
fs/udf/super.c:282: warning: `tokens' defined but not used
make[2]: *** [fs/udf/super.o] Error 1

I tried to compile it as a module and inside the kernel too. Please help me!
