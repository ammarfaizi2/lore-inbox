Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRBQTwu>; Sat, 17 Feb 2001 14:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRBQTwk>; Sat, 17 Feb 2001 14:52:40 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:35384 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131028AbRBQTwe>; Sat, 17 Feb 2001 14:52:34 -0500
Date: Sat, 17 Feb 2001 20:57:10 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Thomas Widmann <thomas.widmann@icn.siemens.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP: bind process to cpu
In-Reply-To: <BGEDIODHBENLENEMBEPAIEDFCAAA.thomas.widmann@icn.siemens.de>
Message-ID: <Pine.LNX.4.21.0102172054180.884-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Thomas Widmann wrote:

> 
> #cat /proc/1310/cpus_allowed
> ffffffff
> 
> Now, if i want to run this process on only one cpu, i which way
> do i have to set the bitmask ?
> Let's say, i want to run it on cpu0. how look's the bitmask ?
> 

Wild guess: as this is a bitmask, you must "or" the bitmask with (1 <<
cpu_number). 1 for CPU 0 only, 5 for CPU 0 and 2, etc, etc.

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

