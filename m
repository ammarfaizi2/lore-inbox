Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTFKWGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFKWGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:06:44 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:45196 "EHLO
	rwcrmhc13.attbi.com") by vger.kernel.org with ESMTP id S264551AbTFKWGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:06:06 -0400
Message-ID: <3EE7AB05.4010601@attbi.com>
Date: Wed, 11 Jun 2003 15:19:49 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 (PPC build) -- drivers/net/hp100.ko needs unknown symbol isa_readl
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a configuration dependency change is needed.

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70; fi
WARNING: /lib/modules/2.5.70/kernel/drivers/net/hp100.ko needs unknown 
symbol isa_readl
WARNING: /lib/modules/2.5.70/kernel/drivers/net/hp100.ko needs unknown 
symbol isa_memset_io
WARNING: /lib/modules/2.5.70/kernel/drivers/net/hp100.ko needs unknown 
symbol isa_memcpy_toio
WARNING: /lib/modules/2.5.70/kernel/drivers/net/hp100.ko needs unknown 
symbol isa_memcpy_fromio

