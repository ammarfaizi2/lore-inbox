Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbQL3Gkf>; Sat, 30 Dec 2000 01:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbQL3GkY>; Sat, 30 Dec 2000 01:40:24 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:32006 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S132993AbQL3GkU>; Sat, 30 Dec 2000 01:40:20 -0500
Message-ID: <3A4D7D32.20A9DC87@atlanta.com>
Date: Sat, 30 Dec 2000 01:14:10 -0500
From: Raymond Carney <rayc@atlanta.com>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New info -- HPT370 RAID support now possible? (was New possibilities for 
 HPT370 RAID support?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read everything that I can find regarding support of the Highpoint
controllers RAID functionality under Linux, and I understand what the issues
have been. The one promising bit of information that I dug up in this process is
that the 'pseudo' RAID functionality of the Highpoint and Promise IDE RAID
controllers is now supported in FreeBSD (4.2-RELEASE and 5.0-CURRENT). My
question is, can the new BSD code be leveraged to add support for these
controllers to the Linux kernel, and could we reasonably expect to see such
support in the near future?

(I think that most all of the relevant/important bits are in ata-raid.c and/or
ata-raid.h. In
any event, the IDE/ATA guy over on the FreeBSD side is Soren Schmidt
(sos@freebsd.org), and he
wrote all of the stuff for this. It is my understanding that he got all of the
info on how Highpoint lays out the geometry of the array directly from
Highpoint, and that they were "very forthcoming" with whatever information that
the FreeBSD team asked for. 

There are also indications of support in OpenBSD and NetBSD's pciide driver,
based on work done by Chris Cappuccio (chris@dqc.org) and Manuel Bouyer
(bouyer@netbsd.org))


Please CC: me directly on any replies, and Thanks very much in advance.
-- 
    ______________________________________________________________________ 
/***   ________________________________________________________________   ***\
 Raymond Carney       <> Discovery consists of seeing what everybody 
 rayc@atlanta.com     <> has seen and thinking what nobody has thought. 
 860.774.1939         <>                     - Albert Von Szent-Gyorgyi 
       ________________________________________________________________ 
\***______________________________________________________________________***/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
