Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUAMSrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUAMSrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:47:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45028 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264925AbUAMSrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:47:05 -0500
Date: Tue, 13 Jan 2004 19:46:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [patch] 2.6.1-mm2: document in must-fix that modular IDE is
Message-ID: <20040113184657.GP9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

broken
Reply-To: 
In-Reply-To: <20040110014542.2acdb968.akpm@osdl.org>
Fcc: =sent-mail

Hi Andrew,

the patch below documents in must-fix.txt that modular IDE is broken.

Please apply
Adrian

--- linux-2.6.1-mm2/Documentation/must-fix.txt.old	2004-01-13 19:36:17.000000000 +0100
+++ linux-2.6.1-mm2/Documentation/must-fix.txt	2004-01-13 19:37:09.000000000 +0100
@@ -36,6 +36,11 @@
   We need to understand whether the proposed BIO split code will suffice
   for this.
 
+drivers/ide
+~~~~~~~~~~~
+
+o modular IDE is broken
+
 drivers/input/
 ~~~~~~~~~~~~~~
 
