Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEWLj>; Fri, 5 Jan 2001 17:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRAEWL3>; Fri, 5 Jan 2001 17:11:29 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:64782
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S129324AbRAEWLI>; Fri, 5 Jan 2001 17:11:08 -0500
Date: Fri, 5 Jan 2001 17:11:07 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: ACPI error message with linux-2.4.0 and MS-6167 motherboard
Message-ID: <20010105171107.A1381@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an error message from linux-2.4.0 which I wasn't getting
with linux-2.4.0-test10.  I have an MS-6167 motherboard.  Both kernels
report

Jan  5 16:39:17 jhereg kernel:  BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
Jan  5 16:39:17 jhereg kernel:  BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)

Later on with 2.4.0, I get

Jan  5 16:39:18 jhereg kernel: ACPI: System description tables found
Jan  5 16:39:18 jhereg kernel: ACPI: System description tables loaded
Jan  5 16:39:18 jhereg kernel:     ACPI-0281: *** Error: Ns_search_and_enter: Bad character in ACPI Name
Jan  5 16:39:18 jhereg kernel:     ACPI-0281: *** Error: Ns_search_and_enter: Bad character in ACPI Name
Jan  5 16:39:18 jhereg kernel: ACPI: Subsystem enable failed

I don't see this with v2.4-test10.  Instead I see

Jan  5 16:57:06 jhereg kernel: ACPI: "AWARD" found at 0x000f60f0
Jan  5 16:57:06 jhereg kernel: ACPI: unreserved table memory @ 0x0fff3000!
Jan  5 16:57:06 jhereg kernel: ACPI: missing RSDT at 0x0fff3000

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
