Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSLJSwM>; Tue, 10 Dec 2002 13:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSLJSwM>; Tue, 10 Dec 2002 13:52:12 -0500
Received: from unknown.Level3.net ([63.210.233.154]:28065 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S264723AbSLJSwL> convert rfc822-to-8bit; Tue, 10 Dec 2002 13:52:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Units and meaning of stats in /proc/partitions
Date: Tue, 10 Dec 2002 13:59:54 -0500
Message-ID: <8075D5C3061B9441944E137377645118012DD6@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Units and meaning of stats in /proc/partitions
Thread-Index: AcKgflN6+7shmNRjQXm4vtcgN48peQ==
From: "Rechenberg, Andrew" <arechenberg@shermfin.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted earlier about a problem with poor disk I/O and I've been
checking out /proc/partitions and was wondering what the units are for
the columns listed.  I've checked the Documentation directory and done
some Googling and haven't been able to find out what everything means.

Could someone give me a basic understanding of the data in
/proc/partitions, or point me to some docs that do?  Here is an example
from my system and it seems there is a lot of wio:

awk -F\  '{print $4 " " $9}' /proc/partitions
name wio

sda 10597274
sda1 762
sda2 0
sda5 2429291
sda6 1377213
sda7 3297029
sda8 12477
sda9 3480502
sdb 13573568
sdb1 13573568
sdc 52542158
sdc1 52542158
sdd 48622592
sdd1 48622592
sde 44479500
sde1 44479500
sdf 44782168
sdf1 44782168
sdg 45638551
sdg1 45638551
sdh 47683013
sdh1 47683013
sdi 44409791
sdi1 44409791
sdj 48352475
sdj1 48352475
sdk 48715677
sdk1 48715677
sdl 42676122
sdl1 42676122
sdm 50988354
sdm1 50988354
sdn 57422238
sdn1 57422238
sdo 0
md0 0

Andrew Rechenberg
Infrastructure Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com
Phone: 513.707.3809
Fax:   513.707.3838
