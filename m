Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUJUR2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUJUR2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270768AbUJUR0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:26:16 -0400
Received: from dmz21.neoplus.adsl.tpnet.pl ([83.24.81.21]:25216 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S270692AbUJURXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:23:54 -0400
Date: Thu, 21 Oct 2004 17:23:49 +0000
From: Piotr Kaczuba <pepe@attika.ath.cx>
Subject: [2.6.9-ac1] "suid_dumpable" [security/commoncap.ko] undefined
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.5
Message-Id: <1098379429l.8350l.0l@orbiter>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel reports this when building modules:

*** Warning: "suid_dumpable" [security/commoncap.ko] undefined!

The capability module fails then to load because it depends on  
commoncap. As a consequence bind cannot be run with the -u option to  
switch its user.

Looking at the ac patch I can see that it has changed "0" to  
"suid_dumpable" but the module obviously lacks the definition.

Please CC me as I'm not subscribed.

Piotr Kaczuba


