Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDEC51 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDEC50 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 21:57:26 -0500
Received: from pop.gmx.de ([213.165.64.20]:54035 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261807AbTDEC5Z (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 21:57:25 -0500
Message-ID: <3E8E48C2.60203@gmx.net>
Date: Sat, 05 Apr 2003 05:08:50 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kernel@ddx.a2000.nu, jonathan@explainerdc.com, adam.johansson@madsci.se,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       ataraid-list@redhat.com, dakota@dakotabcn.net, mast@lysator.liu.se,
       alanmiles@hfx.eastlink.ca
Subject: Promise 202XX: neither IDE port enabled
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

[CC:ed all people who had problems with CONFIG_PDC202XX_FORCE]

I'm currently debugging these Promise Fasttrak recognition problems.
PDC20270: neither IDE port enabled (BIOS)
is one of those pesky messages you will see if it doesn't work.
Could you (if you have the hardware) please test 2.4.21-pre7 with

CONFIG_PDC202XX_FORCE=y

in your .config? If you prefer using the frontends for configuration, 
the option is labeled

"Special FastTrak Feature"

and set it to Y.
If enabling this option causes any problems, please tell me.
Note: this message is about 2.4.21-pre7 (and later) ONLY.

Thank you for testing this.

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org

