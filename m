Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266493AbRGGPiA>; Sat, 7 Jul 2001 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266496AbRGGPhu>; Sat, 7 Jul 2001 11:37:50 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:13390
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266493AbRGGPhp>; Sat, 7 Jul 2001 11:37:45 -0400
Message-Id: <200107071537.f67FbcG01719@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Paulo" <pmateiro@hotpop.com>
cc: linux-kernel@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: NCR 35XXXX MCA bus and SMP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 07 Jul 2001 10:37:37 -0500
From: James Bottomley <James.Bottomley@hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And i have a NCR 3525 with MCA bus and 8 processors and 512MB RAM , i
> tried Suse 6.4 and Red Hat 7.1 , but nome detected my MCA bus , the 8
> processors and more than 64MB ... i tried kernel parameter mem=512m ,
> but no results... only 64MB .... i recompiled the kernel (2.4.2) with
> MCA=y and SMP =y ... and no results... somebody can help me ?

Machines like this require a special SMP HAL to get them to work.  You could 
try the experimental kernels from http://www.hansenpartnership.com/voyager  
which contain the SMP HAL for the voyager systems (which is what a 3525 is).

James Bottomley





