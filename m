Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVIDPMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVIDPMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVIDPMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 11:12:07 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:18576 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750898AbVIDPMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 11:12:06 -0400
From: Daniel Goller <morfic@gentoo.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Brand-new notebook useless with Linux...
Date: Sun, 4 Sep 2005 10:10:54 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200509031859_MC3-1-A720-F705@compuserve.com> <20050904052351.GB30279@alpha.home.local> <Pine.LNX.4.63.0509032240310.3393@r3000.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.63.0509032240310.3393@r3000.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041010.54433.morfic@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for my V2311US with Broadcom 4318 these drivers worked with ndiswrapper: 
ftp://ftp.support.acer-euro.com/notebook/ferrari_4000/driver/winxp64bit/80211g.zip
while these did not: 
http://www.broadcom.com/products/Wireless-LAN/802.11-Wireless-LAN-Solutions/BCM94318
PCIID: 14e4:4318

the ati-drivers 8.16.20 worked very well with the xpress 200 (ATI IXP) in it 
at 1280x768 (proprietary drivers seem to be a problem with software-suspend, 
which might be why i have not successfully resumed yet, vbetools to help here 
does not compile for me..yet?)

the twice as fast clock problem you will find several times on kernel.org's 
bugzilla for now add "noapic" to the kernel parameters, this works here at 
least till it is fixed (i havent tried booting 2.6.13 w/o it to be honest)

i get the charge of my battery, no info on current use 
through /proc/acpi/battery

have not really tried using mmc slot

i hope this helps you anything

Daniel
