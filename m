Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSFGWq1>; Fri, 7 Jun 2002 18:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317203AbSFGWq0>; Fri, 7 Jun 2002 18:46:26 -0400
Received: from h-64-105-137-63.SNVACAID.covad.net ([64.105.137.63]:28053 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315276AbSFGWqZ>; Fri, 7 Jun 2002 18:46:25 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 7 Jun 2002 15:46:10 -0700
Message-Id: <200206072246.PAA06920@adam.yggdrasil.com>
To: thunder@ngforever.de
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thunder from the hill" <thunder@ngforever.de> wrote:
[...]
>> 	for (i = 1; i < parent->num_children; i++) {
>> 	   max_phys = min(max_phys, parent->childqueue[0].max_phys_segments);
>> 	   max_hw = min(max_hw, parent->childqueue[0].max_hw_segments);
>> 	   max_sec = min(max_sec, parent->childqueue[0].max_sectors);
>> 	}

>Just a question: Did you mean parent->childqueue[0] here, or rather 
>parent->childqueue[i]?

	parent->childqueue[i].  Thanks for correcting it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
