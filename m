Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbRGOUgw>; Sun, 15 Jul 2001 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbRGOUgm>; Sun, 15 Jul 2001 16:36:42 -0400
Received: from force.4t2.com ([195.230.37.100]:15129 "EHLO force.4t2.com")
	by vger.kernel.org with ESMTP id <S267018AbRGOUgg>;
	Sun, 15 Jul 2001 16:36:36 -0400
To: linux-kernel@vger.kernel.org
Path: news.abyss.4t2.com!not-for-mail
From: x@abyss.4t2.com (Thomas Weber)
Newsgroups: 4t2.lists.linux.kernel
Subject: Re: Oops triggered by ftp connection attempt through Linux firewall
Date: 15 Jul 2001 22:33:03 +0200
Organization: The Abyss of 4t2.com
Message-ID: <9isulv$v75$1@pandemonium.abyss.4t2.com>
In-Reply-To: <20010712101219.D5476@linuxcare.com> <20010712145811.A8082@hapablap.dyn.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010712145811.A8082@hapablap.dyn.dhs.org>,
Steven Walter <srwalter@yahoo.com> wrote:
>On Thu, Jul 12, 2001 at 10:12:19AM -0700, Ned Bass wrote:
>> A kernel Oops error occurs on a Linux 2.4.6 system that provides IP
>> masquerading for a local area network. The crash is triggered when a
>> connection is attempted to port 21 on ftp.freesoftware.com from any
>> host on the local network which uses the Linux system as its default
>> gateway.  Attempting to connect to port 21 on the Linux system itself
>> results in a no route to host error message.  The severity of the crash
>> prevents interactive access to the system, and a hard reboot is required.
>> The error has been 100% reproducible using the scenario described above.
>> After the Oops, the filesystems can be synced using Alt-Printscreen-S,
>> however attempting to remount readonly using Alt-Printscreen-U caused
>> additional kernel panics.
>
>I have been seeing the same, or a very similar bug, on another NAT
>machine.  This one is of almost the same setup, using Netfilter, FTP,
>and PPPoE.  The oops resulting from this bug it attached.
>
>Interesting, my system is also using the in-kernel pppoe driver.
>Perhaps there is a bug and/or interaction in the pppoe driver with
>netfilter?

FWIW, I've never seen this with any of the 2.4.x kernels i've been using on 
my gateway. But i'm NOT using the kernel pppoe driver, instead i use
the rp-pppoe-2.5-1 rpm (redhat 7.0) currently with 2.4.6-pre3 + ipsec patches 
(uptime ~7 days now).

  Tom
