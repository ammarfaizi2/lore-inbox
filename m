Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUHTN1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUHTN1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUHTN1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:27:13 -0400
Received: from czf-prosek6.supernetwork.cz ([81.31.22.46]:34944 "EHLO
	noodles.netw") by vger.kernel.org with ESMTP id S267205AbUHTN1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:27:11 -0400
From: Jan Spitalnik <jan@spitalnik.net>
Subject: 2.6.8.1 slews system clock
Date: Fri, 20 Aug 2004 15:27:07 +0200
User-Agent: KMail/1.7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201527.07126.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after updating kernel to 2.6.8.1 the system clock slews by 1 second every 10
seconds into future. I tried turning off ACPI, but that had no effect.

root@largo:~# ntpdate tik.cesnet.cz;sleep 10;ntpdate tik.cesnet.cz
20 Aug 13:55:01 ntpdate[5315]: step time server 195.113.144.201 offset
-24.488611 sec
20 Aug 13:55:13 ntpdate[5321]: step time server 195.113.144.201 offset
-1.042110 sec

on second machine the effect is opposite, ie the clock slews backwards.
Any ideas?

Thanks,

--
Jan Spitalnik
jan@spitalnik.net
