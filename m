Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTEWRDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTEWRDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:03:32 -0400
Received: from HDOfa-03p5-117.ppp11.odn.ad.jp ([61.196.12.117]:11702 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S264099AbTEWRDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:03:31 -0400
Date: Sat, 24 May 2003 02:16:35 +0900 (JST)
Message-Id: <20030524.021635.74748205.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc3 : 1394 : Cannot detect hard drive(s?).
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.0.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After 2.4.21-rc2,driver of IEEE1394 storage ( a.k.a. sbp2 ) is not able to
detect IEEE1394 Hard Drive.

Message of /proc/scsi/sbp2/2 at 2.4.21-rc1 is below:
IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 878 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S200
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 64
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes

# If Max speed is not specified,this issue is happened,too :-(

Message of /proc/scsi/scsi at 2.4.21-rc1 (after -rc2,this message is *not*
displayed... ) for IEEE1394 hard drive(s) is below :

Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: SV8004H          Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 02


Regards,
 Ohta 
