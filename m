Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSIKKu5>; Wed, 11 Sep 2002 06:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSIKKu5>; Wed, 11 Sep 2002 06:50:57 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:27828 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318693AbSIKKu4>; Wed, 11 Sep 2002 06:50:56 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 11 Sep 2002 03:55:38 -0700
Message-Id: <200209111055.DAA02518@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.34 reverses order of IDE disk drives
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have a computer with an IDE disk drive as master on the
primary interface, and another IDE disk drive as slave on the
secondary interface.  Under all kernels through 2.5.33, the
first disk appears as /dev/discs/disc0/disc, and the second
one is /dev/discs/disc1/disc.  Under 2.5.34, they appear to
be reversed.

	I understand that Jens is submitting a port of Alan and
Andre's IDE updates, so I'm tempted to just wait and see if the
problem goes away as a side-effect of that update.  However, I figure
I ought to at least mention it in case it rings a bell for anyone.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


