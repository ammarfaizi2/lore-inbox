Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTK0Lij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTK0Lij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:38:39 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:741 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264484AbTK0Lif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:38:35 -0500
Date: Thu, 27 Nov 2003 12:38:22 +0100
From: Florian Weingarten <fw@go.cc>
To: linux-kernel@vger.kernel.org
Subject: ACPI Battery Status Problem in 2.6.0-test11
Message-ID: <20031127113821.GA15346@gatekeeper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-KEY-ID: 0x65C91285
X-PGP-URL: http://defiant.regio.net/~fw/
X-PGP-FINGERPRINT: 066E AFD8 5A70 3F4D B33D  C51F 89F5 BB94 65C9 1285
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: rxSda0Zrge+mhF3VbfGg+V0-eaO0q2xDoTEeeG1ivnd2qOH+jLTAge@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a problem in kernel 2.6.0-test10 which seems to be still there in
2.6.0-test11.. My ACPI battery status does not work! I compiled it into the
kernel (not as module) but /proc/acpi/battery/ is empty. Everything works
fine with kernel 2.4.22.

I get the following boot message (sorry for long lines):

ACPI: AC Adapter [ACAD] (on-line)
    ACPI-0352: *** Error: Looking up [Z000] in namespace, AE_NOT_FOUND search_node c11fc800 start_node c11fc800 return_node 00000000
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BIF] (Node c11fc800), AE_NOT_FOUND
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (49 C)

The other ACPI stuff (Temperatures, LID Status, etc.) works, only battery
status doesn't. Would be nice if anybody could tell me if it's my fault or a
a kernel problem. Thanks in advance.


Flo
-- 
Those who desire to give up Freedom in order to gain Security,
will not have, nor do they deserve, either one. (T. Jefferson)
