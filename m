Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131411AbQKGXo7>; Tue, 7 Nov 2000 18:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135718AbQKGXn6>; Tue, 7 Nov 2000 18:43:58 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:16962 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S135417AbQKGXnF>; Tue, 7 Nov 2000 18:43:05 -0500
Date: Wed, 8 Nov 2000 01:50:51 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: David Schwartz <davids@webmaster.com>
cc: RAJESH BALAN <atmproj@yahoo.com>, linux-kernel@vger.kernel.org
Subject: RE: malloc(1/0) ??
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.21.0011080149010.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	The program does not work. A program works if it does what it's supposed to
> do. If you want to argue that this program is supposed to print "ffffff"
> then explain to me why the 'malloc' contains a zero in parenthesis.
> 
> 	The program can't possibly work because it invokes undefined behavior. It
> is impossible to determine what a program that invokes undefined behavior is
> 'supposed to do'.

May I remind you guys that a malloc(0) is equal to a free(). There is no
way that any mem get's malloced. 

You only get a coredump if the program accesses a page it shouln't, and
since whe're talking 5 bytes here or so, you have a change that you don't
cross a boundary.

>	DS


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
