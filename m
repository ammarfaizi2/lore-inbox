Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318716AbSH1FMl>; Wed, 28 Aug 2002 01:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSH1FMk>; Wed, 28 Aug 2002 01:12:40 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51423 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318716AbSH1FMk> convert rfc822-to-8bit; Wed, 28 Aug 2002 01:12:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: h.grosenick@t-online.de (Holger Grosenick)
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: System freeze on 2.4.18 / 19 SMP
Date: Wed, 28 Aug 2002 07:17:06 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208280717.06600.hgrosenick@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


now i changed CMOS settings and have 

/dev/hda	ide0	DVD
/dev/hde	ide2	60 GB
/dev/hdf	ide2	80 GB (only 1 large partitition)
/dev/hdg	ide3	60 GB

but that didn't change the behaviour. After i mounted /dev/hdf the system gets 
unstable: a normal "df" receives a "segmentation fault".

Might there be a problem with large disks? My system is two years old and i 
have these problems since i had to replace 2x30 GB by 2x60 GB, because one of 
the hard discs crashed. 

I mount /dev/hdf only when a want to make a backup, so normally the disc is 
switched off (mobile rack) and then the system is quite stable, it might 
freeze but that can't be reproduced.
