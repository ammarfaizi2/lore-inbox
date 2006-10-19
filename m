Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWJSJRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWJSJRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWJSJRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:17:35 -0400
Received: from av2.karneval.cz ([81.27.192.122]:26953 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030358AbWJSJRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:17:34 -0400
Message-ID: <453742AE.3010201@gmail.com>
Date: Thu, 19 Oct 2006 11:17:34 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: ipw2100-admin@linux.intel.com
Subject: ipw2200: "ieee80211: Info elem: parse failed"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since 2.6.19-rc1 I'm getting these messages from ipw2200 driver:
ieee80211: Info elem: parse failed: info_element->len + 2 > left : 
info_element->len+2=8 left=2, id=128.

The driver says:
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4km
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 3 (level, low) -> IRQ 3
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10

and works, but the message is annoying, since the driver prints it again and 
again. What could be wrong?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
