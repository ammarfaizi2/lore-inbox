Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGQWy7>; Wed, 17 Jul 2002 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSGQWy7>; Wed, 17 Jul 2002 18:54:59 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:30033
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S316823AbSGQWy6>; Wed, 17 Jul 2002 18:54:58 -0400
Message-Id: <200207172257.g6HMvqt07123@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW SUBARCHITECTURE FOR 2.5.26] support for NCR voyager 
 (3/4/5xxx series)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jul 2002 17:57:52 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

There's basically nothing different from the 2.5.21 one except for updates and 
changes to the arch-split and a few file tidy ups in mach-voyager.

The patch is in two parts:  The i386 sub-architecture split is separated from 
the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.21.diff (109k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.26.diff (146k)

You must apply the split diff before applying the voyager one.

These two patches are also available as separate bitkeeper trees (the voyager 
tree is a superset of the arch-split one):

http://linux-voyager.bkbits.net/voyager-2.5
http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


