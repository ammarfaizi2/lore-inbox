Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUCFAZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 19:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUCFAZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 19:25:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58076 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261500AbUCFAZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 19:25:26 -0500
Subject: 2.6.4-rc2-bk.current: Build failure w/ "supprot for AFAVLAB 8port
	boards" patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078532723.797.48.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Mar 2004 16:25:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
	I just bk pulled from Linus' tree and when I tried to build, I got the
compile error listed below:

Dropping the PCI entry at line 1896, added by the changeset in the URL
below, lets it build. 

http://linus.bkbits.net:8080/linux-2.5/cset%401.1647.2.2?nav=index.html|ChangeSet@-1d

thanks
-john

  LD      arch/i386/kernel/built-in.o
drivers/serial/8250_pci.c:1896: `PCI_DEVICE_ID_AFAVLAB_P030' undeclared here (not in a function)
drivers/serial/8250_pci.c:1896: initializer element is not constant
drivers/serial/8250_pci.c:1896: (near initialization for `serial_pci_tbl[74].device')
drivers/serial/8250_pci.c:1898: initializer element is not constant
drivers/serial/8250_pci.c:1898: (near initialization for `serial_pci_tbl[74]')
drivers/serial/8250_pci.c:1902: initializer element is not constant
drivers/serial/8250_pci.c:1902: (near initialization for `serial_pci_tbl[75]')
drivers/serial/8250_pci.c:1905: initializer element is not constant
drivers/serial/8250_pci.c:1905: (near initialization for `serial_pci_tbl[76]')
drivers/serial/8250_pci.c:1908: initializer element is not constant
drivers/serial/8250_pci.c:1908: (near initialization for `serial_pci_tbl[77]')
drivers/serial/8250_pci.c:1911: initializer element is not constant
drivers/serial/8250_pci.c:1911: (near initialization for `serial_pci_tbl[78]')
drivers/serial/8250_pci.c:1914: initializer element is not constant
drivers/serial/8250_pci.c:1914: (near initialization for `serial_pci_tbl[79]')
drivers/serial/8250_pci.c:1917: initializer element is not constant
drivers/serial/8250_pci.c:1917: (near initialization for `serial_pci_tbl[80]')
drivers/serial/8250_pci.c:1920: initializer element is not constant
drivers/serial/8250_pci.c:1920: (near initialization for `serial_pci_tbl[81]')
drivers/serial/8250_pci.c:1923: initializer element is not constant
drivers/serial/8250_pci.c:1923: (near initialization for `serial_pci_tbl[82]')
drivers/serial/8250_pci.c:1926: initializer element is not constant
drivers/serial/8250_pci.c:1926: (near initialization for `serial_pci_tbl[83]')
drivers/serial/8250_pci.c:1929: initializer element is not constant
drivers/serial/8250_pci.c:1929: (near initialization for `serial_pci_tbl[84]')
drivers/serial/8250_pci.c:1936: initializer element is not constant
drivers/serial/8250_pci.c:1936: (near initialization for `serial_pci_tbl[85]')
drivers/serial/8250_pci.c:1943: initializer element is not constant
drivers/serial/8250_pci.c:1943: (near initialization for `serial_pci_tbl[86]')
drivers/serial/8250_pci.c:1950: initializer element is not constant
drivers/serial/8250_pci.c:1950: (near initialization for `serial_pci_tbl[87]')
drivers/serial/8250_pci.c:1956: initializer element is not constant
drivers/serial/8250_pci.c:1956: (near initialization for `serial_pci_tbl[88]')
drivers/serial/8250_pci.c:1967: initializer element is not constant
drivers/serial/8250_pci.c:1967: (near initialization for `serial_pci_tbl[89]')
drivers/serial/8250_pci.c:1971: initializer element is not constant
drivers/serial/8250_pci.c:1971: (near initialization for `serial_pci_tbl[90]')
drivers/serial/8250_pci.c:1978: initializer element is not constant
drivers/serial/8250_pci.c:1978: (near initialization for `serial_pci_tbl[91]')
drivers/serial/8250_pci.c:1981: initializer element is not constant
drivers/serial/8250_pci.c:1981: (near initialization for `serial_pci_tbl[92]')
drivers/serial/8250_pci.c:1988: initializer element is not constant
drivers/serial/8250_pci.c:1988: (near initialization for `serial_pci_tbl[93]')
drivers/serial/8250_pci.c:1992: initializer element is not constant
drivers/serial/8250_pci.c:1992: (near initialization for `serial_pci_tbl[94]')
drivers/serial/8250_pci.c:1995: initializer element is not constant
drivers/serial/8250_pci.c:1995: (near initialization for `serial_pci_tbl[95]')
drivers/serial/8250_pci.c:2004: initializer element is not constant
drivers/serial/8250_pci.c:2004: (near initialization for `serial_pci_tbl[96]')
drivers/serial/8250_pci.c:2008: initializer element is not constant
drivers/serial/8250_pci.c:2008: (near initialization for `serial_pci_tbl[97]')
drivers/serial/8250_pci.c:2012: initializer element is not constant
drivers/serial/8250_pci.c:2012: (near initialization for `serial_pci_tbl[98]')
drivers/serial/8250_pci.c:2013: initializer element is not constant
drivers/serial/8250_pci.c:2013: (near initialization for `serial_pci_tbl[99]')
make[2]: *** [drivers/serial/8250_pci.o] Error 1
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2


