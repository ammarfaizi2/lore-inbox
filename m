Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313150AbSDOKAg>; Mon, 15 Apr 2002 06:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313144AbSDOKAf>; Mon, 15 Apr 2002 06:00:35 -0400
Received: from mail.webmaster.com ([216.152.64.131]:24992 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S313143AbSDOKAf> convert rfc822-to-8bit; Mon, 15 Apr 2002 06:00:35 -0400
From: David Schwartz <davids@webmaster.com>
To: <ivan@es.usyd.edu.au>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 15 Apr 2002 03:00:30 -0700
In-Reply-To: <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au>
Subject: Re: Memory Leaking. Help!
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020415100031.AAA10679@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>No, I do not. That is why I asked is there a way to find out what is
>eating ram. I am not sure if this a leakage. I am only a paranoid
>sysadmin.

	In fact, you have no reason whatsoever to believe the memory is leaking. 
It's just being *used*.

>>What does ps -aux imply has all the memory ?

>Top at 9am showed 3.2GB of availabe memory.
>
>Top at 10am showed 2.3Gb of available memory
>
>This top at 11am
>10:19am  up 13:23,  6 users,  load average: 0.07, 0.03, 0.01
>143 processes: 142 sleeping, 1 running, 0 zombie, 0 stopped
>CPU0 states:  0.0% user,  5.0% system,  0.0% nice, 94.0% idle
>CPU1 states:  0.0% user,  1.0% system,  0.0% nice, 98.0% idle
>Mem:  3799080K av, 2215132K used, 1583948K free,    1580K shrd,  377916K
>buff
>Swap: 8192992K av,       0K used, 8192992K free                 1515392K
>cached

	If you don't want the memory to be used, take it out of the system and let 
it sit on your desk. If you put the memory in the system, the system assumes 
that you want to use it. It keeps data in memory that it would otherwise 
throw away, that we if it's used again, it doesn't have to be fetched from 
disk.

	DS


