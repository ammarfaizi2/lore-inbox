Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290527AbSARL67>; Fri, 18 Jan 2002 06:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290569AbSARL6u>; Fri, 18 Jan 2002 06:58:50 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:48142 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S290527AbSARL6j>;
	Fri, 18 Jan 2002 06:58:39 -0500
Date: Fri, 18 Jan 2002 12:58:34 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Finalize new device naming convention ?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3C480DEA.C824751E@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Boissiere (boissiere@mediaone.net) mentions on
http://people.ne.mediaone.net/boissiere/Status-18-Jan-2002.html :

* Pending Finalize new device naming convention (Linus Torvalds)

Is this about user space visible device names , like the stuff in /dev/ ?

I have some strong ( negative ) feeling about the current ( pre 2.5.x ) state
of that. Where is/was/will be this discussed.

The gist of my problem is that the entries in /dev/ doesn't always refer
to the same device as 5 minutes before. Even without a reboot in between.

Examples : 

name      |    now             | some minutes later
-------------------------------------------------
sdb       | a SCSI disk        | some other SCSI disk
hda6      | my root FS         | my swap partition
dsp1      | my main speakers   | my rear speaker
eth0      | my LAN connection  | my ISP connection

There must be some lasting ID that can be used to refer to devices,
something that is not changed by some semi-related events.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
