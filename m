Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbSLLUEO>; Thu, 12 Dec 2002 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbSLLUEO>; Thu, 12 Dec 2002 15:04:14 -0500
Received: from sun.cesr.ncsu.edu ([152.14.51.17]:40638 "EHLO sun.cesr.ncsu.edu")
	by vger.kernel.org with ESMTP id <S267460AbSLLUEN>;
	Thu, 12 Dec 2002 15:04:13 -0500
Date: Thu, 12 Dec 2002 15:12:01 -0500 (EST)
From: Anu <avaidya@unity.ncsu.edu>
X-X-Sender: avaidya@sun.cesr.ncsu.edu
To: linux-kernel@vger.kernel.org
Subject: detecting layout in RAID
In-Reply-To: <20021211183059.A19030@light-brigade.mit.edu>
Message-ID: <Pine.GSO.4.44.0212121507430.3980-100000@sun.cesr.ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
	I am trying to detect layouts of the RAID configuration (I have a
software RAID set up. ) Mine is currently left symmetric and the way I am
trying to detect layout is to reaad consecutive blocks and look for
whether there is a big dp when it has to move all the way across..

there seems to be no such thing. e.g.

1  2  3  P
5  6  P  4
9  P  7  8
P 10 11 12

should show some timing difference when block 5 is read -  i get an
exponentially decreasing curve !

any ideas? or other newsgroups i can hit

