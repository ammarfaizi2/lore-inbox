Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCRFbM>; Sun, 18 Mar 2001 00:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCRFbC>; Sun, 18 Mar 2001 00:31:02 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:51951 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S129524AbRCRFar>;
	Sun, 18 Mar 2001 00:30:47 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AB447CD.8020509@ksu.ru>
Date: Sun, 18 Mar 2001 08:29:49 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.3-pre4] comparing eepro100 & e100 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm setting up a new server with Intel 82559 LOM (733470-066),
this is ASUS CUR-DLS.

While testing the NIC performance with eepro100 driver,
I was getting those famous "card reports no resources" and "too much 
work in interrupt".

The perfomance test was actually a "ping -f -s 65507"
from another host (both hosts are in 100baseTX-FD IBM switch)
and some other program doing basicly the same.

I played around with module parameters but had no luck.

So I've had to try the Intel supplied driver *e100-1.5.5a*.

ftp://download.intel.com/df-support/2250/eng/e100-1.5.5a.tar.gz

And it works just rock&solid - no problems at all.


