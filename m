Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270408AbUJUM4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270408AbUJUM4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbUJUMwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:52:42 -0400
Received: from mail.charite.de ([160.45.207.131]:9148 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S269088AbUJUMwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:52:00 -0400
Date: Thu, 21 Oct 2004 14:51:54 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-ac1 doesn't compile
Message-ID: <20041021125154.GL17874@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcc version 3.4.2 (Debian 3.4.2-3)

...

  CC [M]  drivers/usb/core/usb.o
  CC [M]  drivers/usb/core/hub.o
  CC [M]  drivers/usb/core/hcd.o
drivers/usb/core/hcd.c:132: error: parse error before '>>' token
drivers/usb/core/hcd.c:132: error: initializer element is not constant
drivers/usb/core/hcd.c:132: error: (near initialization for usb2_rh_dev_descriptor[12]')
drivers/usb/core/hcd.c:132: error: parse error before '>>' token
drivers/usb/core/hcd.c:132: error: initializer element is not constant
drivers/usb/core/hcd.c:132: error: (near initialization for usb2_rh_dev_descriptor[13]')
drivers/usb/core/hcd.c:155: error: parse error before '>>' token
drivers/usb/core/hcd.c:155: error: initializer element is not constant
drivers/usb/core/hcd.c:155: error: (near initialization for usb11_rh_dev_descriptor[12]')
drivers/usb/core/hcd.c:155: error: parse error before '>>' token
drivers/usb/core/hcd.c:155: error: initializer element is not constant
drivers/usb/core/hcd.c:155: error: (near initialization for usb11_rh_dev_descriptor[13]')
make[4]: *** [drivers/usb/core/hcd.o] Error 1
make[3]: *** [drivers/usb/core] Error 2
make[2]: *** [drivers/usb] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory /usr/src/linux-2.6.9-ac1'
make: *** [stamp-build] Error 2

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                                   AIM.  ralfpostfix
