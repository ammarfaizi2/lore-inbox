Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDEW5S>; Thu, 5 Apr 2001 18:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRDEW5I>; Thu, 5 Apr 2001 18:57:08 -0400
Received: from snifit.smb.utfors.se ([195.58.112.20]:1424 "EHLO
	snifit.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S129245AbRDEW4x>; Thu, 5 Apr 2001 18:56:53 -0400
Message-Id: <3.0.1.32.20010406005458.00d99c68@post.utfors.se>
X-Mailer: Windows Eudora Light Version 3.0.1 (32)
Date: Fri, 06 Apr 2001 00:54:58 +0200
To: linux-kernel@vger.kernel.org
From: Jakob Kemi <jakob.kemi@post.utfors.se>
Subject: Parport probe
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Ok, maybe this isn't the right list for this question. In 2.2.x the
parport_probe module extracted the ieee1284 device id correctly and added to the
proc fs. However this doesn't seem to work for me in 2.4.x
I only have one device to test it on and since I know there have been some
difficulties regarding the device string's length bytes etc I post my device_id string here
the first two bytes says that length is 96 and the following is the string 
"MFG:Winbond;MDL:SA5459B;CLS:DIGCAM;DES:Winbond's DIGCAM driver can not be found in the system;"

I have tested to build, parport, parport_pc and ieee1284 both as modules and static into the kernel.
Is there some option I need to enable. As far as I understand the CONFIG_PARPORT_1284 should be enough??

Bye
	Jakob


