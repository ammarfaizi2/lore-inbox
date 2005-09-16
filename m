Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbVIPRVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbVIPRVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbVIPRVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:21:21 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:8684 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1161196AbVIPRVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:21:20 -0400
Message-ID: <432AFF0E.8090904@candelatech.com>
Date: Fri, 16 Sep 2005 10:21:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kallsyms error when compiling 2.6.13 + patch 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying this patch:

http://www.candelatech.com/oss/candela_2.6.13.patch

and using this config:

http://www.candelatech.com/oss/kernel26_p2.cfg

I had to set the CONFIG_KALLSYMS_EXTRA_PASS option
to get the compile to work.

Compile machine is up-to-date FC2 system (dual Xeon).

Is this a known issue?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

