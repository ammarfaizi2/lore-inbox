Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbULAKT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbULAKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULAKT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:19:26 -0500
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:60812
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S261351AbULAKTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:19:18 -0500
Message-ID: <41AD9A33.3070205@cola.voip.idv.tw>
Date: Wed, 01 Dec 2004 18:17:23 +0800
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-15
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000604090507050405030005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000604090507050405030005
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit

Hi Ingo,

System hangs on my notebook with RT-0.7.31-15 when running
"/sbin/hwclock --hctosys --localtime".
Cursor stops blinking, no response to SysRq-b.
But if I set "hardirq-preempt=0" in kernel command line, the problem is
gone.

config is attached. Is there anything I can do to provide you more
useful informantion?

-- 
Best Regards,
Wen-chien Jesse Sung

--------------000604090507050405030005
Content-Type: application/x-gzip;
 name="config-0.7.31-15.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-0.7.31-15.gz"

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
--------------000604090507050405030005--
