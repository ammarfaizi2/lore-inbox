Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTBYN6V>; Tue, 25 Feb 2003 08:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbTBYN6V>; Tue, 25 Feb 2003 08:58:21 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26634 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265250AbTBYN6U>; Tue, 25 Feb 2003 08:58:20 -0500
Message-ID: <3E5B7934.5060306@aitel.hist.no>
Date: Tue, 25 Feb 2003 15:09:56 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au
Subject: Re: Linux 2.5.63 - nfs mount fails
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My first attempt at mounting nfs with 2.5.63 resulted in a segfault.
Two more attempts at the same directory and another resulted in
mount processes in D-state.

2.5.59 has no problems.

The relevant line from etc/fstab:
www.aitel.hist.no:/www/innhold    /www     nfs 
rsize=4096,wsize=8192,user,noauto,hard,intr  0      0

The kernel has UP, preempt, everything compiled-in
(no module support at all), devfs compiled but not mounted.

I can do tcpdumps if that helps.

Helge Hafting

