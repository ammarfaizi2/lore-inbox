Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbTCWRq2>; Sun, 23 Mar 2003 12:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbTCWRq2>; Sun, 23 Mar 2003 12:46:28 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:42645 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S263133AbTCWRq1>; Sun, 23 Mar 2003 12:46:27 -0500
Subject: some new phenomena with IO-APIC and ACPI on via kt333/vt8235
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048442253.433.42.camel@bonnie79>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2003 18:57:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to report some experiences with an epox 8k5a3+ mobo and
linux-2.5.65-ac3. (my problems should also apply to previous 2.5 and 2.4
kernels)
I've always had trouble, when I used IO-APIC with this board. ACPI never
did work, cause every 2.5 kernel I tried, did not boot past the ide
setup (XT-PIC + ACPI). IO-APIC + ACPI did boot, but ACPI didn't work -
at least it wouldn't shut down properly. Now I found a way to boot
2.5.65-ac3 with ACPI enabled in XT-PIC mode: I disabled both HPT 374 IDE
Controllers. ACPI then could do proper shutdown.
But a new problem occured: My RTL 8139 NIC did not work anymore ( it has
always worked fine in both XT and IO APIC setups). Then I tried to boot
again with IO-APIC mode (HPT-374 still disabled) and the 8139 worked
fine again. Hmmm ?? 

Any other suggestions than throwing my mobo to trash?

thx
Christian


