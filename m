Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTF1LRV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 07:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbTF1LRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 07:17:21 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:62592 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S265152AbTF1LRU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 07:17:20 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: linux-kernel@vger.kernel.org
Subject: kernel bug at buffer.c:511
Date: Sat, 28 Jun 2003 08:30:13 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306280830.14034.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error on a Tyan 2466, 2 x AMD2400MP, 512 MB unbuffered 
DDR, 80 gb ide system disk and 3ware ide raid controller with 2 x wd2000 data 
drives.

kernel bug at buffer.c:511
invalid operand: 0000
cpu: 1
eip: 0010:[c01388459>] not tainted
eflags: 00210206

The application running was a 4vl2 application using mmap() to access frame 
buffer data from a a bttv878 device.

I can repleat this error within about 10 minutes of running.  Is there any 
other data of interest?
-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
