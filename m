Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUD3QHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUD3QHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:06:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:62898 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265096AbUD3QGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:06:09 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: usbcore.ko linkage problem on x86_64
Date: Fri, 30 Apr 2004 18:12:10 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301812.10676.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There seems to be a linkage problem with the usbcore.ko module in the 
2.6.6-rc2-mm2 and 2.6.6-rc3-mm1 kernels.  Namely, I get this message:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.6-rc3-mm1; fi
WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/usb/core/usbcore.ko needs 
unknown symbol destroy_all_async

after "make modules_install".  AFAICS, it does not occur for the 2.6.6-rc2 
kernel.

Yours,
RJW

