Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUDUFvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUDUFvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 01:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUDUFvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 01:51:33 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:47030 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264983AbUDUFvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 01:51:31 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: No luck getting 2.6.x kernel to work with ACPI on compaq laptop
Date: Wed, 21 Apr 2004 05:51:30 +0000 (UTC)
Organization: Cistron
Message-ID: <c65252$9cs$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1082526690 9628 62.216.30.38 (21 Apr 2004 05:51:30 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Compaq presario 700EA locks up dead during boot with
ACPI enabled. With bootoption acpi=off (or not compiled into the kernel)
the machine works just fine.

I put on acpi debug and typed over by hand (laptop's dont have serial
ports these days anymore) :

ACPI: Subsystem revision 20040326
tbxface-0017[03] acpi_load_tables: ACPI tables succesfully acquired
Parsing all Control Methods: [......]
Table [DSDT] (id F005) - 433 Objects with 44 Devices 109 Methods 15
Regions
Parsing all Control Methods: 
Table [SSDT] (id f003) - 3 objects with 0 Devices 0 Methods 0 Regions
ACPI: IRQ10 SCI: Edge set to level trigger

After this the machine is dead in the water.
No magic sysrq or anything.

Any ideas how to solve this issue ?
I googled around a bit but found nothing usefull.
I upgraded bios to latest available from compaq, with no different
results.

Help/suggestions appreciated.

Danny
-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

