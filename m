Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264213AbTCXTnT>; Mon, 24 Mar 2003 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264370AbTCXTnT>; Mon, 24 Mar 2003 14:43:19 -0500
Received: from mail3.efi.com ([192.68.228.90]:10771 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S264213AbTCXTnR>; Mon, 24 Mar 2003 14:43:17 -0500
Message-ID: <3E7F61D6.D1017E70@efi.com>
Date: Mon, 24 Mar 2003 11:51:50 -0800
From: Kallol Biswas <kallol.biswas@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usb printer driver and zero length transfer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I am new to USB world and looking for clarification on usb
printer's
behavior when transferring data with size  multiple of  wMaxPacketSize.

I have been running redhat 7.1 (linux kernel 2.4.2-2) on x86 PC with a
USB 1.1 controller. There is a target mode printer driver running on the

other side.

On the host the device file is /dev/usb/lp0.
If a data packet of 64 bytes is sent with

"cat data8 > /dev/usb/lp0" , the size of data8 is 64, a zero length
packet
at the end of the transfer is not sent.

Is this a correct behavior?  How do we force the printer driver send
a zero length packet at the end of a transfer if the packet size is
a multiple of wMAxPacketSize?


Kallol

