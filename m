Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFXP25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFXP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:28:57 -0400
Received: from orngca-mls02.socal.rr.com ([66.75.160.17]:26800 "EHLO
	orngca-mls02.socal.rr.com") by vger.kernel.org with ESMTP
	id S262530AbTFXP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:28:55 -0400
Message-Id: <5.2.0.9.0.20030624084045.02918560@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 24 Jun 2003 08:42:47 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: Kernel & BIOS return differing head/sector geometries
Cc: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org,
       John Coffman <johninsd@san.rr.com>
In-Reply-To: <3EF86E50.20504@zytor.com>
References: <20030624081319.G1326@almesberger.net>
 <20030624010906.08ad32f3.ktech@wanadoo.es>
 <20030624013908.B1133@pclin040.win.tue.nl>
 <bd8hgj$cas$1@cesium.transmeta.com>
 <20030624012220.E1418@almesberger.net>
 <3EF7D33E.6060009@zytor.com>
 <20030624081319.G1326@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:29 AM 06/24/2003, H. Peter Anvin wrote:
>Werner Almesberger wrote:
>>H. Peter Anvin wrote:
>>
>>>Presumably "linear", not "lba32".  I *presume* LILO has enough 
>>>wherewithal to use EBIOS if it's available and fall back to CBIOS 
>>>otherwise for at least one of these options.  I at least thought "lba32" 
>>>would force EBIOS usage.
>>
>>Yes, that seems to be the case. (All the LBA32 code is from John
>>Coffman. I've copied him in case he's interested in the thread.)
>>But you're still betting on the BIOS to either implement EDD
>>correctly, or at least to report that it doesn't support it.
>>Call me paranoid, but I wouldn't be at all surprised if there are
>>some BIOSes out there that get this wrong.
>
>Well... it's somewhat unlikely given the sheer amount of things that would 
>probably break.  The rule these days is that if it works with the 
>particular versin of M$ that's currently shipping then it's good, but I'm 
>pretty sure NTLOADER uses EDD.


Likewise GRUB.

Win 95 & 98 require EDD.

Win NT, 2000, and XP use it to boot (NTLDR).

--John



         PGP encrypted e-mail preferred (www.pgpi.com)
         My KeyID: 178A1C6B  (good until 31-Dec-2004)
         Keyserver at ldap://keyserver.pgp.com
         LILO links at http://freshmeat.net/projects/lilo

