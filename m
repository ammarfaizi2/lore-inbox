Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTDGH7i (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTDGH7i (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:59:38 -0400
Received: from [203.197.168.150] ([203.197.168.150]:22280 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263315AbTDGH7h (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 03:59:37 -0400
Message-ID: <3E913335.96D0DAEA@tataelxsi.co.in>
Date: Mon, 07 Apr 2003 13:43:41 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: registration function of Cardbus driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Our Cardbus driver was using register_driver/unregister_driver
function  of cb_enabler.c    for registration and unregistration in
RH7.1
But in RH 8.0 , we are not able to find cb_enabler.o file in
/modules/pcmcia directory even when we compile the kernel with PCMCIA
CARDBUS support.
So our Cardbus driver is giving unresolved symbol register_driver and
unregister_driver.

Has this function renamed.
If not where it is?

Please help.
Any pointers will be highly appreciated.

Thanks & regards
Prasanta

