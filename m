Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRAKDEa>; Wed, 10 Jan 2001 22:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRAKDEV>; Wed, 10 Jan 2001 22:04:21 -0500
Received: from chello212186054181.11.vie.surfer.at ([212.186.54.181]:10766
	"EHLO pluto.i.zmi.at") by vger.kernel.org with ESMTP
	id <S129939AbRAKDEK> convert rfc822-to-8bit; Wed, 10 Jan 2001 22:04:10 -0500
From: Michael Zieger <m.zieger@zmi.at>
Organization: ZMI EDV http://www.zmi.at
Date: Thu, 11 Jan 2001 04:04:07 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011104025105.09006@saturn>
Content-Transfer-Encoding: 8BIT
Subject: Display bug at configuration of 2.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a minor display order bug in 2.4.0 when using make menuconfig, 
under "SCSI":

--- Some SCSI devices (e.g. CD jukebox) support multiple LUNs           
[ ]   Enable extra checks in new queueing code                          
[ ]   Probe all LUNs on each SCSI device                                

I believe the "---" line should be after the "Enable extra checks" 
line, right? Could confuse people.

mike
-- 
// Michael Zieger, BSc.Ing.    ---    Zieger Michael EDV-Lösungen
// http://www.zmi.at                             Linux 2.4.00 SMP
//
// Atheism is a non-prophet organization.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
