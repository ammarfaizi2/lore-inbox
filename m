Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbTH1KIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTH1KIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:08:17 -0400
Received: from actinium.btinternet.com ([194.73.73.66]:60544 "EHLO
	actinium.btinternet.com") by vger.kernel.org with ESMTP
	id S263884AbTH1KCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:02:05 -0400
Message-ID: <1591781.1062064923473.JavaMail.root@127.0.0.1>
Date: Thu, 28 Aug 2003 11:02:03 +0100 (BST)
From: subodh@btopenworld.com
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-MAILER: talk21.com WAS v2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I have been using kernel mode driver for my Alcatel speedtouch modem since 2.4.21 and at the moment i am using it with 2.6.0-test4-mm2. I never had any problem in using this drive since it was included in  2.5.xx series It works like a charm. Few things you need to be aware of.
A. Your ppp software should be pppoatm compatible
B. You need to compile ppp atm support in the kernel (You can also use it as a module).
C. When you load the firmware using modem_run command use the option for kernel mode driver. I think its -k.
D. Configure your options file as suggested at http://www.linux-usb.org/SpeedTouch/

Launch pppd daemon without any option and you should get connection.

Subodh Shrivastava
PS: I also used user mode driver for while but i was plagued by the loss of sync problem which resulted in slow download speed. Switching to kernel mode driver i never had those problems. 
