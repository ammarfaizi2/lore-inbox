Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTICJYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTICJYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:24:21 -0400
Received: from mx0.gmx.net ([213.165.64.100]:11035 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261693AbTICJYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:24:14 -0400
Date: Wed, 3 Sep 2003 11:24:13 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
Subject: pdflush question...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <14227.1062581053@www37.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it worth having a kernel config option to vary the number of 'pdflush'
kernel threads?

For embedded, systems with no swap and maybe uniproc (?), perhaps one
pdflush kthread would do?

Perhaps more generally, the number could be linked to the number of
processors and/or swap devices or spindles- this would eliminate having to configure
it, and improve downward and upward scaling, perhaps?

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

