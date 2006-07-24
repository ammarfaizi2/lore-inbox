Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWGXNZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWGXNZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWGXNZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:25:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:25770 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932175AbWGXNZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:25:50 -0400
Message-Id: <200607241325.k6ODPnTW003266@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc2 () on SPARC64: Compile failure
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 24 Jul 2006 09:25:49 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 24 Jul 2006 09:25:49 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting:

  CC [M]  drivers/scsi/esp.o
  drivers/scsi/esp.c: In function `esp_should_clear_sync':
  drivers/scsi/esp.c:2758: error: structure has no member named `data_cmnd'
  make[2]: *** [drivers/scsi/esp.o] Error 1
  make[1]: *** [drivers/scsi] Error 2
  make: *** [drivers] Error 2
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
