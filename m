Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSCOKgt>; Fri, 15 Mar 2002 05:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSCOKgj>; Fri, 15 Mar 2002 05:36:39 -0500
Received: from mark.mielke.cc ([216.209.85.42]:35337 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S289243AbSCOKg1>;
	Fri, 15 Mar 2002 05:36:27 -0500
Date: Fri, 15 Mar 2002 05:32:11 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UNIX bench better on 2.2 than 2.4?
Message-ID: <20020315053211.A5619@mark.mielke.cc>
In-Reply-To: <3C91A822.7030304@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C91A822.7030304@linkvest.com>; from jean-eric.cuendet@linkvest.com on Fri, Mar 15, 2002 at 08:52:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 08:52:02AM +0100, Jean-Eric Cuendet wrote:
> Results:
> Host1: 2xPIII 550MHz / 1Gb RAM / RAID5 SCSI / 2.4.6smp + LVM
>        Result: 164.7
> Host2: 2xPIII 866MHz / 1Gb RAM / RAID1 soft IDE / 2.4.16smp + LVM
>        Result: 195.7
> Host3: 1xPIII 800MHz / 512Mb RAM / IDE / 2.2.19 RedHat 6.2
>        Result: 208.6
> Host4: 1xPIII 600MHz / 256Mb RAM / IDE / 2.4.19-pre2-ac4-preempt
>        Result: 153.6

I dunno what Unix bench is... but isn't 153.6/208.6 close to 600/800
in terms of a fraction?

It isn't really fair to compare different machine configurations with
different OS's, and declare that the OS is the only factor involved.

Make Host3 or Host4 have both versions of the linux kernel in /boot
and try each on the same machine.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

