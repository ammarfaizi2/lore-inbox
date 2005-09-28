Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVI1QF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVI1QF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVI1QF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:05:58 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:48756 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751083AbVI1QF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=g4G5OnzD5ivtnb3bEFVuxcQxEcndaa4OLbAqgMccWVF+rfeyTBPodof5ieEHN4t6SeZyQpiIV/uoFaon7qhQETwoDrf8ZLP0bmdp8+AIlbcI4HrGndaoM/VF4YgLGttXthEN/gB8cmWXs4qeAhZudXUFKLMc2ikEcXYZtLo9TVY=  ;
Date: Wed, 28 Sep 2005 18:06:04 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: linux-kernel@vger.kernel.org
Cc: kbuild-devel@lists.sourceforge.net
Subject: [PATCH] make usb storage note visible in Kconfig
Message-ID: <20050928160604.GA23955@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	the following patch splits the NOTE: in the Device Drivers->USB submenu of
	Kconfig thus making the whole of it readable on 600x800 terminals.
	(Otherwise, the line was too big and disappeared into nowhere.)

	
	Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- current/drivers/usb/storage/Kconfig.orig	2005-09-28 17:58:37.000000000 +0200
+++ current/drivers/usb/storage/Kconfig	2005-09-28 17:59:40.000000000 +0200
@@ -2,7 +2,8 @@
 # USB Storage driver configuration
 #
 
-comment "NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information"
+comment "NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'"
+comment "may also be needed; see USB_STORAGE Help for more information"
 	depends on USB
 
 config USB_STORAGE

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
