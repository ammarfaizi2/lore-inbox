Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVLBShI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVLBShI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVLBShI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:37:08 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:11714 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750850AbVLBShH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:37:07 -0500
Message-ID: <43909451.20105@candelatech.com>
Date: Fri, 02 Dec 2005 10:37:05 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Keyboard broken in 2.6.13.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with a super-micro P8SCI motherboard.

The default FC2 kernel (2.6.10-1.771_FC2smp) works fine, but
when I try to boot a 2.6.13.2 kernel, I see this error:

i8042.c: Can't read CTR while initializing i8042

If I hit the keyboard early in the boot, the system will just reboot.

If I wait a bit, then it will boot to a prompt, but no keyboard input
is accepted.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

