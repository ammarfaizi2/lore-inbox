Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUL2OnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUL2OnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUL2OnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:43:05 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:29879 "EHLO
	tnetsmtp1.mail.isp") by vger.kernel.org with ESMTP id S261343AbUL2OnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:43:03 -0500
Message-ID: <41D2C273.9040003@telefonica.net>
Date: Wed, 29 Dec 2004 15:42:59 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and time drift
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just didn't notice the time drift during normal conditions, but it 
gets REALLY bad when I suspend my laptop.
As a reference, I suspended it aproximately at 01:00 and resumed it at 
15:25 but the clock says 22:30. It does not occur in 2.6.9. Dmesg output 
relative to time dmesg|grep time:

$ dmesg|grep time
Using pmtmr for high-res timesource
PCI: Setting latency timer of device 0000:00:1f.5 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
