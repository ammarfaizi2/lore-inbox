Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRDLTvD>; Thu, 12 Apr 2001 15:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135294AbRDLTuy>; Thu, 12 Apr 2001 15:50:54 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:13712 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135293AbRDLTum>; Thu, 12 Apr 2001 15:50:42 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 12:50:41 -0700
Message-Id: <200104121950.MAA00291@baldur.yggdrasil.com>
To: drepper@cygnus.com
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	I am aware of a couple of cases where code relied on static
>> variables being allocated contiguously, but, in both cases, those
>> variables were either all zeros or all non-zeros, so my proposed
>> change would not break such code.

>Continuous placement is not the only property defined by
>initialization.  There are many more.  You cannot change this since it
>will quite a few programs and libraries and subtle and hard to
>impossible to identify ways.  Simply educate programmers to not
>initialize.

	If it is so simple to "educate" programmers on this,
could you provide and example or some specifics, especially on why
this should not even be a compiler option?  Surely that will save
you some iterations in this discussion.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
