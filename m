Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTAPL0s>; Thu, 16 Jan 2003 06:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTAPL0s>; Thu, 16 Jan 2003 06:26:48 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:11236 "EHLO
	mailrelay.tugraz.at") by vger.kernel.org with ESMTP
	id <S266852AbTAPL0r>; Thu, 16 Jan 2003 06:26:47 -0500
Message-ID: <1042716941.3e26990dc83b1@webmail.tugraz.at>
X-Priority: 3 (Normal)
Date: Thu, 16 Jan 2003 12:35:41 +0100
From: Maier Gerfried <moali@sbox.tugraz.at>
To: linux-kernel@vger.kernel.org
Subject: Clock does not keep time
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 195.49.27.70
X-Oragnization: University of Technology Graz / Austria
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel-List,

I'm using Linux (kernel 2.4.20 with acpi-20021212 and swsusp-beta16 patches) on 
my Acer Travelmate 630 notebook.

Unfortunately I experience the problem, that under some [1] conditions the RTC 
does not keep time. It runns in advance compared to the real time, up to 
several hours per 12 hours of time. The machine is quite new, so I don't think, 
that the RTC-battery is already exhausted.

I was able to gain the information that the RTC in this notebook is a BQ3285LF 
(is manufactured from TI  - Datasheet for instance at 
http://www.scanti.ru/docs/datasheets/slus183.pdf - and probably others).

Is such a problem known to you?
Is it possible that it is a kernel issue or do you think it is a hardware-bug?
How could I debug this issue?

Thanks a lot for any suggestions
Maier Gerfried


[1] I was not able to find out under what conditions. I first thought that it 
could be temperatore-dependant, or if the power supply is on line or not, if I 
booted windows before. Unfortunately I was not able to find the reason by now.
-- 

