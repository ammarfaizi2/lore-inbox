Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTEOHIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEOHIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:08:30 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:54660 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262362AbTEOHI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:08:29 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Anders Karlsson" <anders@trudheim.com>,
       "Clemens Schwaighofer" <cs@tequila.co.jp>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Subject: RE: Two RAID1 mirrors are faster than three
Date: Thu, 15 May 2003 08:21:16 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEECDAAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <1052716203.4100.10.camel@tor.trudheim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders.

 >> Why three drives in a Raid1? Raid one is just mirror, or is the
 >> third drive like a "hot" replace drive if one of the others fail?

 > With normal mirroring (one original, one copy) you do have the
 > redundancy and the speed boost at reads, but at mirroring with one
 > original and two copies (I know AIX does this), you get in to a
 > scenario that is quite handy. Say you run a large database in a
 > 24/7 operation. You want to back the database up, but you can only
 > get 5-10 minutes downtime on it. You then quiesce the database,
 > split off the second copy from the mirror, mount that as a
 > separate file system and back that up while the original with its
 > first copy has already stepped back into full use.
 >
 > Once you finished your backup, you add your split-off copy back to
 > the original and primary copy and you are back where you started.

Does this cause any problems, with the third disc now being out of
date compared to the first two?

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.481 / Virus Database: 277 - Release Date: 13-May-2003

