Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTB1Miy>; Fri, 28 Feb 2003 07:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTB1Miy>; Fri, 28 Feb 2003 07:38:54 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:12553 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267869AbTB1Mix>; Fri, 28 Feb 2003 07:38:53 -0500
Message-ID: <3E5F5B1F.5050801@aitel.hist.no>
Date: Fri, 28 Feb 2003 13:50:39 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.62 devfs shrink
References: <200302280314.TAA11682@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

> Tangential note:	
> 
> 	For what it's worth, my preference would be to change from
> /dev/discs/disc0/part1 to /dev/disk/0/part1, but I think it would

Yes, that is nice and short.  There is no need for the disc0 part,
we know it is a disk because it is in /dev/disk.

> probably do more harm than good to try to coordinate such a change
> with switching devfs.  If you want to try to make a change where

Well, I wouldn't mind a disc->disk transition.  It seems to mee there 
aren't that many devfs users yet so I don't think it'll be that much of 
a problem.

> people will eventually have to update their systems, I think it would
> probably make more sense to survey existing devfs naming practices and
> try to come up with some recommendations harmonize them a bit.  For
> example, should the directory names be singular or plural (/dev/loop
> or /dev/loops, /dev/disk or /dev/disks)?  I would recommend signular
> because it is less English-centric.  

Singular is nice, because we think about /dev/disk/4 (one
particular disk) a lot more than we think about "the collection
/dev/disks"


Helge Hafting

