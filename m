Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUAMXtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbUAMXtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:49:09 -0500
Received: from www3.mail.lycos.com ([209.202.220.160]:62443 "HELO lycos.com")
	by vger.kernel.org with SMTP id S265406AbUAMXtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:49:06 -0500
To: "Sumit Narayan" <sumit_uconn@lycos.com>
Date: Tue, 13 Jan 2004 18:48:52 -0500
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <IAGKMJMFCOKCMJAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Disk Partition Details - 2.6.0
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know the access to a particular partition on a disk. In 2.4, I used the 'request' structure in the ide-disk.c to obtain the exact drive I was accessing(reading/writing). But, in 2.6, gendisk is being introduced, and I am unable to get to the exact drive I would like to trace. Could someone help me to find the exact drive from within the kernel.

I tried using the gendisk->minor, but that did not help me, as it gave value 64 always, even if I made read/write on different disks. gendisk->major is 3. How do I catch the other partitions/drives?

>From what I know, the partition values are now shifted to block layer. Could you help me find out the exact place, from where I could find out the partition details.

Thanks in advance,
Sumit


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
