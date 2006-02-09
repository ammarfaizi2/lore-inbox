Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWBIFJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWBIFJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBIFJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:09:55 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:49537 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750795AbWBIFJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:09:55 -0500
Message-ID: <43EACED9.2030405@t-online.de>
Date: Thu, 09 Feb 2006 06:10:49 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Assert: CPU #..., mangle/filter comefrom(....) = ...
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XpkOd8ZDZeUBFP8lIQk+laV8AHf78EEWitFzg0g1QT1NzUhA87jg8F@t-dialin.net
X-TOI-MSGID: 9f170f08-a987-4844-9558-f2579be83363
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As there probably is a reason to printk assertions:

[   28.616455] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   28.617112] ASSERT: CPU #0, mangle comefrom(f75ae890) = 1
[   28.617115] ASSERT: CPU #0, filter comefrom(f79ca090) = 2
[   28.934256] ASSERT: CPU #0, mangle comefrom(f7051890) = 1
[   28.934260] ASSERT: CPU #0, filter comefrom(f7aa9090) = 2
[   32.766440] ASSERT: CPU #0, mangle comefrom(f709c090) = 1
[   32.766443] ASSERT: CPU #0, filter comefrom(f71f3090) = 2

cu,
 Knut
