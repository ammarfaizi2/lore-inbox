Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTHVDWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 23:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTHVDWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 23:22:34 -0400
Received: from post.tau.ac.il ([132.66.16.11]:6351 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262989AbTHVDWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 23:22:33 -0400
Subject: 2.6.0-test3-bk8: why is CONFIG_ACPI_HT a dependency for
	CONFIG_ACPI?
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061509498.15422.14.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 22 Aug 2003 05:18:14 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.1; VDF: 6.21.0.26; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if I am missing something, but CONFIG_ACPI_HT is a
dependency for CONFIG_ACPI.
>From the description of CONFIG_ACPI_HT its used for enumerating logical
and physical processors. I have a single processor with no
hyperthreading, why do I need this feature enabled, is there something
the description is not saying?

This is under 2.6.0-test3-bk8.

-- 
Micha Feigin
michf@math.tau.ac.il

