Return-Path: <linux-kernel-owner+w=401wt.eu-S965068AbWLMS4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWLMS4w (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWLMS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:56:52 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60056 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965068AbWLMS4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:56:51 -0500
Message-Id: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19 (current from git) on SPARC64: Can't mount /
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 13 Dec 2006 15:56:46 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 13 Dec 2006 15:56:47 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running kernel du jour straight from git on my SPARC Ultra 1 for
some time now on Aurora Corona (Fedora relative, development branch). For a
few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked fine,
as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so I had to
rebuild a kernel to check if the problem lay elsewhere). Unpacking the
initrds for 2.6.19 and 2.6.19.1 shows the same (nash script) /init and the
same modules in both (ext3 + jbd, scsi_mod, sd_mod, esp, others).

I'm stumped. Any clue?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

