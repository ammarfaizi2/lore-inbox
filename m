Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUDDPaz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUDDPaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:30:55 -0400
Received: from CPE000102d0fe24-CM0f1119830776.cpe.net.cable.rogers.com ([65.49.144.24]:1284
	"EHLO thorin.norang.ca") by vger.kernel.org with ESMTP
	id S262425AbUDDPaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:30:52 -0400
Date: Sun, 4 Apr 2004 11:30:50 -0400
From: Bernt Hansen <bernt@norang.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.4 & 2.6.5 breaks e100 support on my laptop
Message-ID: <20040404153050.GC2691@norang.ca>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Norang Consulting Inc
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Toshiba Tecra S1 laptop with a built-in ethernet card which
uses the e100 driver.  The ethernet works fine with linux kernel 2.6.3.
As of 2.6.4 (and 2.6.5) I get the following message at startup:

e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Enabling device 0000:02:08.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:02:08.0 to 64
e100: eth%d: e100_eeprom_load: EEPROM corrupted
e100: probe of 0000:02:08.0 failed with error -11

and the ethernet no longer works.  (The 2nd last message eth%d is
probably missing the ethernet number as a parameter to this printk)

Please cc: me in replies since I am not subscribed to the list.

Let me know if there is anything I can do to help fix this problem.

Thanks,
Bernt.
-- 
Bernt Hansen     Norang Consulting Inc.
