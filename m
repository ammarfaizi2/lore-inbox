Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271673AbTGRBw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271676AbTGRBw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:52:28 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3235 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S271673AbTGRBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:52:27 -0400
Message-ID: <3F17558B.2030704@myrealbox.com>
Date: Fri, 18 Jul 2003 10:03:55 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riley@Williams.Name, davej@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation Error in arch/i386/boot/setup.S
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
           This may be applied.

Regards,
-Romit


@@ -894,7 +894,7 @@
        subw    $DELTA_INITSEG, %si
        shll    $4, %esi                        # Convert to 32-bit pointer

-# jump to startup_32 in arch/i386/kernel/head.S
+# jump to startup_32 in arch/i386/boot/compressed/head.S
 #
 # NOTE: For high loaded big kernels we need a
 #      jmpi    0x100000,__BOOT_CS


