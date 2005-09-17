Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVIQMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVIQMnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVIQMnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:43:00 -0400
Received: from pil.idi.ntnu.no ([129.241.107.93]:47258 "EHLO pil.idi.ntnu.no")
	by vger.kernel.org with ESMTP id S1751099AbVIQMnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:43:00 -0400
From: =?ISO-8859-1?Q?=20H=E5vard?= Bjerke <Havard.Bjerke@idi.ntnu.no>
Date: Sat, 17 Sep 2005 14:42:54 +0200
To: linux-kernel@vger.kernel.org
Subject: "Failed to acquire semaphore" with ACPI since 2.6.10-rc2
Message-ID: <20050917124254.GV5384@idi.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Virus-Scanned-By: mimedefang.idi.ntnu.no, using CLAMD
X-SMTP-From: Sender=<havarbj@furu.idi.ntnu.no>, Relay/Client=furu.idi.ntnu.no [129.241.107.64], EHLO=furu.idi.ntnu.no
X-Filter-Time: 0 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been sticking with 2.6.9 for a while. Since 2.6.10-rc2, when ACPI is
enabled, I spontaneously (I don't know how to provoke them) get lots of these
messages:

osl-0940 [1279] os_wait_semaphore     : Failed to acquire
semaphore[00000100018befa0|1|0], AE_TIME
osl-0940 [1292] os_wait_semaphore     : Failed to acquire
semaphore[00000100018befa0|1|0], AE_TIME
...

Same problem in 2.6.14-rc1. With acpi=off, there's no problem. In
2.6.10-r1, with or without ACPI, no problem.

I have an nForce 3 mainboard in an Asus laptop, arch is x86_64, and all
kernels are vanilla and without proprietary nvidia in the tests.

Please CC my personal address.

Thanks,
Havard
