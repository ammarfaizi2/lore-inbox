Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRBWXWb>; Fri, 23 Feb 2001 18:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130786AbRBWXWV>; Fri, 23 Feb 2001 18:22:21 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:27655 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S130768AbRBWXWQ>; Fri, 23 Feb 2001 18:22:16 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: UDP attack? How to suppress kernel msgs?
Date: Fri, 23 Feb 2001 15:21:51 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHIEMAEOAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of my servers running 2.4.1 was attacked earlier today.  I have a strong
feeling it went down because the kernel was logging too many messages to
syslog.  There's over 100,000 lines of the following in my syslog:

Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 202.96.140.146:20567
to 21
6.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 209.249.213.145:36338
to 2
16.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 194.225.45.233:33762
to 21
6.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 211.54.39.161:14958 to
216
.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 202.96.140.167:3467 to
216
.115.239.40:113 ulen 1472

How do I suppress these types of messages from hogging up all the CPU?

Thanks,
Vibol Hou

