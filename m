Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTEJNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTEJNbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:31:24 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:32693 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264108AbTEJNbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:31:22 -0400
Message-ID: <3EBD0221.2070605@POGGS.CO.UK>
Date: Sat, 10 May 2003 14:44:01 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Revised patch for 2.4.21-rc2: typo in drivers/net/Config.in
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Engage brain, then submit patch - here is the correct patch...


Peter.


--- drivers/net/Config.in       2003-05-10 14:24:19.000000000 +0100
+++ drivers/net/Config.in.new   2003-05-10 14:24:45.000000000 +0100
@@ -185,7 +185,7 @@
      dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 
$CONFIG_PCI
      dep_tristate '    EtherExpressPro/100 support (eepro100, original 
Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
      if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
      else
         dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO 
$CONFIG_EEPRO100
      fi



