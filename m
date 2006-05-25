Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWEYSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWEYSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWEYSTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:19:25 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:22532 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id S1030237AbWEYSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:19:25 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: b44 driver issues?
Date: Thu, 25 May 2006 19:19:00 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200605251919.00614.dj@david-web.co.uk>
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a Dell Inspiron 5150 laptop with a Broadcom BCM4401 network card which 
uses the b44 driver.

With recent kernels (I've tested with Ubuntu's 2.6.15,  vanilla 2.6.16.18 and 
2.6.17-rc5) the driver loads without error but the interface isn't 
registered.

In dmesg:
b44.c:v1.00 (Apr 7, 2006)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 177
eth0: Broadcom 4400 10/100BaseT Ethernet 00:11:43:7b:69:ae

# ifconfig eth0
eth0: error fetching interface information: Device not found

With Ubuntu's 2.6.12 kernel everything works as expected. I've not tried any 
kernels between 2.6.12 and 2.6.15, but can do so if it'd be helpful.

Anybody else having problems?

Thanks in advance,
David.

-- 
David Johnson
www.david-web.co.uk - My Personal Website
www.penguincomputing.co.uk - Need a Web Developer?
