Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUBBH3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 02:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUBBH3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 02:29:23 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13974 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265641AbUBBH3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 02:29:22 -0500
Message-ID: <401DFC4C.2080802@blue-labs.org>
Date: Mon, 02 Feb 2004 02:29:16 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI/battery status on Dell Inspiron 8200 broken, 2.6.2-rc3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Battery status got lost in either rc2 or rc3.  It worked in rc1.

powerix klaptopdaemon # cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:
serial number:
battery type:
OEM info:

powerix klaptopdaemon # cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      0 mAh
present voltage:         0 mV

