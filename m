Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270108AbTGPFWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270114AbTGPFWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:22:17 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:21254 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270108AbTGPFWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:22:16 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Wed, 16 Jul 2003 13:04:31 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307160009.08605.mflt1@micrologica.com.hk> <200307161110.50725.mflt1@micrologica.com.hk>
In-Reply-To: <200307161110.50725.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307161240.01972.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With ACPI=off and state saving and powering the device down with 
pci_set_power_state on suspend, it is functional on resume but 
for the IRQ allocation. IRQ is set to 0 and card events work.

Getting on with ACPI then and expect this to take a while...

Others: pci=biosirq generates endless oopses/segfaults on boot
(no serial console to grab), perhaps someone else can reproduce this.

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

