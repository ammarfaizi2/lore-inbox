Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVKAVLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVKAVLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVKAVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:11:50 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:22733 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751220AbVKAVLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:11:49 -0500
Message-ID: <435FC01D.4090807@handhelds.org>
Date: Wed, 26 Oct 2005 19:42:53 +0200
From: Koen Kooi <koen@handhelds.org>
Reply-To: koen@dominion.kabel.utwente.nl
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] correct wording in drivers/usb/net/KConfig
References: <435E2362.6010203@handhelds.org> <20051026170349.GA3921@kroah.com>
In-Reply-To: <20051026170349.GA3921@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050702090409070205080304"
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
X-MailScanner-From: koen@handhelds.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050702090409070205080304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
> On Tue, Oct 25, 2005 at 02:21:54PM +0200, Koen Kooi wrote:
> 
>>+++ drivers/usb/net/Kconfig     2005-10-25 14:10:30.644935296 +0200
>>@@ -294,7 +294,7 @@
>>          This also supports some related device firmware, as used in some
>>          PDAs from Olympus and some cell phones from Motorola.
>> 
>>-         If you install an alternate ROM image, such as the Linux 2.6 based
>>+         If you install an alternate image, such as the Linux 2.6 based
> 
> 
> Your email client ate the tabs in the patch, and you forgot a
> "Signed-off-by:" line for the patch.  Care to try it again?

Sure, attached should be a patch with correct tabs and a signed-off-by line.

regards,

Koen

> 
> thanks,
> 
> greg k-h
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFDX8AdMkyGM64RGpERAohSAKCO1G22HGwFbl4UPOkHm7BzmpBpggCeIPO9
RMhvH5wW/n7BFjPGc00FSlc=
=DLez
-----END PGP SIGNATURE-----

--------------050702090409070205080304
Content-Type: text/x-patch; x-mac-type="0"; x-mac-creator="0";
 name="no-ROM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-ROM.patch"

# Signed-off-by: Koen Kooi <koen@handhelds.org>
============================================================================================================================================================================================
--- ../Kconfig	2005-10-25 14:09:29.000000000 +0200
+++ drivers/usb/net/Kconfig	2005-10-25 14:10:30.000000000 +0200
@@ -294,7 +294,7 @@
 	  This also supports some related device firmware, as used in some
 	  PDAs from Olympus and some cell phones from Motorola.
 
-	  If you install an alternate ROM image, such as the Linux 2.6 based
+	  If you install an alternate image, such as the Linux 2.6 based
 	  versions of OpenZaurus, you should no longer need to support this
 	  protocol.  Only the "eth-fd" or "net_fd" drivers in these devices
 	  really need this non-conformant variant of CDC Ethernet (or in

--------------050702090409070205080304--
