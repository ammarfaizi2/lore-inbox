Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312886AbSDBRwK>; Tue, 2 Apr 2002 12:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312867AbSDBRwA>; Tue, 2 Apr 2002 12:52:00 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:60677 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S312872AbSDBRvw>; Tue, 2 Apr 2002 12:51:52 -0500
Date: Tue, 2 Apr 2002 12:51:52 -0500
Message-Id: <200204021751.g32Hpqi04661@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Confirmation!
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-04-02, "Napanda. C. Pemmaiah" <pemmaiah@cc.usu.edu> wrote:

> 1)  When the system is booted the module gets installed. I was curious
> from where does this installation takes place. As far i learnt from the

This is going to be RedHat distribution specific; it's not a Linux kernel /
networking question.  The RedHat boot scripts take care of module loading,
etc.

> 2)          I removed the module by "rmmod 3c59x" and again installed
> it by "insmod /lib/modules/...../net/3c59x.o". The module got installed
> but in the /proc/modules it shows "3c59x    0(unused)". And from
> /etc/rc.d/init.d if I start the network by saying "./network start" the

This too is a RedHat-specific question.  If you 'insmod 3c59x; ifconfig
eth0 1.2.3.4 ...' by hand, it should surely work.  The /etc/rc.d/init.d
contents on your system are all created / set up by RedHat.

You should check out the redhat-list list, subscribe info at:
https://listman.redhat.com/mailman/listinfo/redhat-list

We also have a searchable archive of it at:
http://marc.theaimsgroup.com/?l=redhat-list&r=1&w=2

HTH,

Hank Leininger <hlein@progressive-comp.com> 
  
