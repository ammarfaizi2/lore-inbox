Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWHURb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWHURb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWHURb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 13:31:59 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:50072 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965056AbWHURb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 13:31:58 -0400
Date: Mon, 21 Aug 2006 13:31:55 -0400
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de, Dirk <noisyb@gmx.net>
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-ID: <20060821173155.GG13641@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca> <1155822530.15195.95.camel@localhost.localdomain> <20060817143633.GF13641@csclub.uwaterloo.ca> <44E74FD9.7000507@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E74FD9.7000507@flower.upol.cz>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 07:52:25PM +0200, Oleg Verych wrote:
> AFAIK many drivers allow multiple opening of device files. If programs do 
> not
> honor any kind of locking (advisory, O_EXCL) use mandatory locking (DOS 2.0
> compatibility, no problems ;)
> 
> Yea. But see RH managers on its videos, happy about usb sticks being plugged
> and worked, he-he:
> <http://www.redhat.com/v/magazine/mov/005_BehindScenes_RHEL4.mov>.
> 
> I've just installed debian-gnu and got all that
> cpufrequtils, powermgmt, acpiutils installed on amd64 laptop
> while i just need:
> ,-
> |modprobe powernow-k8
> |modprobe cpufreq_ondemand
> |echo ondemand >scailing_governor
> `-
> Anyway long, almost 10 years, way to win95 and win98 is never ending ;D

Don't worry, NT4 didn't do that either, you had to wait for windows 2000
before you got a decent kernel and all the power management and hotplug
stuff.

--
Len Sorensen
