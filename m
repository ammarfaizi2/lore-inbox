Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTHOQTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbTHOQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269639AbTHOQJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:58 -0400
Subject: [2.6-test3-bk3] - warning: function not used.
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Governo Eletronico - SP
Message-Id: <1060955886.7188.12.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 10:58:06 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

 While compiling with gcc-3.2:

> arch/i386/kernel/dmi_scan.c:167: warning: `dmi_dump_system'
> defined but not used

 This warnings happens because the only _call_ to
dmi_dump_system() happens when CONFIG_ACPI_BOOT is defined,
but I'm not using ACPI.

thanks,

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

