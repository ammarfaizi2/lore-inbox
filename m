Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTDGQOn (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTDGQOk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:14:40 -0400
Received: from CYRUS.andrew.cmu.edu ([128.2.10.172]:58089 "EHLO
	mail-fe2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S263494AbTDGQOi (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 12:14:38 -0400
Subject: 2.4.21-pre7: error in drivers/ide/Config.in
From: Steinar Hauan <steinhau+@andrew.cmu.edu>
Reply-To: hauan@cmu.edu
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Carnegie Mellon University
Message-Id: <1049732774.30284.10.camel@steinar.cheme.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 07 Apr 2003 12:26:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"make oldconfig" --> works fine

"make xconfig" on the same .config as above produces


./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1

-- 
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA


