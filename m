Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313380AbSDESYm>; Fri, 5 Apr 2002 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSDESYd>; Fri, 5 Apr 2002 13:24:33 -0500
Received: from mail.myrio.com ([63.109.146.2]:12030 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S313380AbSDESYU> convert rfc822-to-8bit;
	Fri, 5 Apr 2002 13:24:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: faster boots?
Date: Fri, 5 Apr 2002 10:23:57 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3D1@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: faster boots?
Thread-Index: AcHcaqXt+urSAYuwQIGGOc1T0gLT0AAYUQFA
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2002 18:23:12.0901 (UTC) FILETIME=[F2442350:01C1DCCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[... cc's trimmed, I guess everyone is on the list... ]

I also would like to speed up boots.  On the systems I'm 
responsible for (set top boxes hooked up to television 
sets) the slowest part of the boot is mounting the five reiser 
filesystems.  I'm using the busybox init and the "boot scripts" 
are actually a single compiled program.

Could mounting filesystems be parallelized effectively?

Three of the five filesystems on are mounted read-only, so I 
don't know what reiserfs is doing at mount that takes so long.
It used to be faster when we were using 2.2.19 with the reiser
3.5 patches...  

Does ext3 mount faster?

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com


