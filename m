Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTG2XWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272382AbTG2XWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:22:42 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:22996 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S272222AbTG2XWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:22:40 -0400
Subject: Re: Linux 2.4.22-pre9
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307291700490.24730@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307291700490.24730@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2003 01:22:03 +0200
Message-Id: <1059520929.26914.140.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> Here goes -pre9, yet another step in 2.4.22 direction.
> 
> It contains a bunch of Netfilter fixes, set of IEEE1394 fixes, couple of
> knfsd fixes amongst others.
> 
> Expect -pre10 tomorrow.

what do you think about including the request_firmware() backport from
Manuel Estrada Sainz?

 Documentation/Configure.help                          |    6 
 Documentation/firmware_class/README                   |   58 +
 Documentation/firmware_class/firmware_sample_driver.c |  121 +++
 Documentation/firmware_class/hotplug-script           |   16 
 include/linux/firmware.h                              |   20 
 lib/Config.in                                         |    4 
 lib/Makefile                                          |    3 
 lib/firmware_class.c                                  |  557 ++++++++++++++++++
 8 files changed, 784 insertions(+), 1 deletion(-)

I already ported drivers/bluetooth/bfusb.c to use the request_firmware()
interface and I will port drivers/bluetooth/bt3c_cs.c after this patch
gets merged.

Regards

Marcel


