Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUICQRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUICQRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269369AbUICQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:17:45 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:62849 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269374AbUICQRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:17:30 -0400
Message-ID: <413898B9.3000403@rtr.ca>
Date: Fri, 03 Sep 2004 12:15:53 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: md RAID over SATA performance
References: <1094169937l.17931l.0l@werewolf.able.es> <1094172444l.17931l.1l@werewolf.able.es> <413826C1.1010203@dgreaves.com>
In-Reply-To: <413826C1.1010203@dgreaves.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >blockdev --getra /dev/sda1
 >blockdev --getra /dev/md0
 >
 >and if needed:
 >blockdev --setra 4096 /dev/sda1
 >blockdev --setra 4096 /dev/md0

The standard hdparm version of the above is the "-a" flag.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
