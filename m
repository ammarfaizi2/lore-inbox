Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKBUag>; Sat, 2 Nov 2002 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSKBUag>; Sat, 2 Nov 2002 15:30:36 -0500
Received: from sun.cesr.ncsu.edu ([152.14.51.17]:27526 "EHLO sun.cesr.ncsu.edu")
	by vger.kernel.org with ESMTP id <S261371AbSKBUae>;
	Sat, 2 Nov 2002 15:30:34 -0500
Date: Sat, 2 Nov 2002 15:37:04 -0500 (EST)
From: Anu <avaidya@unity.ncsu.edu>
X-X-Sender: avaidya@sun.cesr.ncsu.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: an idling kernel
In-Reply-To: <3DC3C1AA.7060602@zytor.com>
Message-ID: <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

disclaimer: if this is the wrong ng to be posting this to, its only due to
ignorance.. I dont know the first thing about where to post this
question..

----------------------------------------------------------------------

Hello,
	Im ready to be beaten up for asking this question ( I am not sure
which group to post to -- all this is new to me) but, I was wondering how
one could figure out if the kernel was in idle mode (or idling).

I *have* tried to look for the answer and here is waht I have come up with
so far :

Process 0 is the idle process.. but, I dont understand how you can tell if
this means that the kernel is in idle mode. Do we just probe the state
field of all process entries and check to see if everyone is sleeping and
conclude that the kernel is idling??

for_each_process(p)
 {
    if(process->state == S)
     {
        countup;
     }
 }

if countup == number of processes, then the kernel was idling?


-anu

********************************************************************************

			     Think, Train, Be

*******************************************************************************


