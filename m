Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSGYWV0>; Thu, 25 Jul 2002 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSGYWV0>; Thu, 25 Jul 2002 18:21:26 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:62163 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S316589AbSGYWVZ>; Thu, 25 Jul 2002 18:21:25 -0400
Message-ID: <3D407ABB.60103@oracle.com>
Date: Fri, 26 Jul 2002 00:24:59 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.28 new serial driver changes tty# for PCMCIA modem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Xircom CardBus modem has moved from /dev/ttyS4 to /dev/ttyS14.

Was that intentional ? The kernel printk is also a bit strange:

[asuardi@dolphin asuardi]$ dmesg | grep tty
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ttyS-14 at I/O 0x4080 (irq = 11) is a 16550A
^^^^^^^

(it works though - message is sent through PPP dialup over the
  Xircom modem :)


--alessandro

  "my actions make me beautiful / and dignify the flesh"
                 (R.E.M., "Falls to Climb")

