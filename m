Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVATK7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVATK7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVATK7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:59:45 -0500
Received: from tweli.aber.ac.uk ([144.124.16.41]:15074 "EHLO tweli.aber.ac.uk")
	by vger.kernel.org with ESMTP id S262111AbVATK6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:58:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16879.36609.94551.926755@aber.ac.uk>
Date: Thu, 20 Jan 2005 10:59:13 +0000
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: [ACPI] Machine no longer enters C3 on 2.6.11-rc1-bk
In-Reply-To: <20050120104033.GA25889@elf.ucw.cz>
References: <20050120104033.GA25889@elf.ucw.cz>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
From: Fred Labrosse <ffl@aber.ac.uk>
X-Sophos-Scanned: from ffl@aber.ac.uk virus scanned OK
X-UWA-Mid: 1Cra0C-00048m-AN
X-UWA-Originating-IP: 193.60.10.49
X-UWA-Bounce-Filter: HKxqVrbHgX2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > bus master activity: is changing all the time, mostly 555555555 and
 > aaaaaaa, and cpu refuses to enter C3 for obvious reasons. I compiled
 > out USB and sound... Does anybody else see the same problem?
 > 

I did notice too that it was never in C3 apart from a bit right at the
beginning, since 2.6.10.  It has always been like that up to 2.6.6, became
better from 2.6.7 (but had other problems with that).

Fred

P.S.  I didn't check bus master activity.  How do you do that?



