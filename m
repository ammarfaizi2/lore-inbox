Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUHNQj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUHNQj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHNQj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:39:28 -0400
Received: from smtp06.web.de ([217.72.192.224]:35286 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S263875AbUHNQjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:39:21 -0400
Subject: Re: [BKPATCH] ACPI for 2.6
From: Marcus Hartig <m.f.h@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 14 Aug 2004 18:40:34 +0200
Message-Id: <1092501634.13263.8.camel@redtuxi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 (1.5.92.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I compile 2.6.8(.1) with this ACPI patch or without, I get this
error while compiling:

  CC      drivers/acpi/dispatcher/dsfield.o
In file included from drivers/acpi/dispatcher/dsfield.c:49:
include/acpi/acnamesp.h:450: error: syntax error before '(' token
include/acpi/acnamesp.h:457: warning: function declaration isn't a
prototype
make[3]: *** [drivers/acpi/dispatcher/dsfield.o] Error 1
make[2]: *** [drivers/acpi/dispatcher] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

?

gcc version 3.4.1 20040714 (Red Hat 3.4.1-7)
config: http://www.marcush.de/.config


Marcus

-- 
www.marcush.de



