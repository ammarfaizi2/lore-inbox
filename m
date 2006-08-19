Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWHSQwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWHSQwo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWHSQwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:52:44 -0400
Received: from main.gmane.org ([80.91.229.2]:16801 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422695AbWHSQwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:52:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Date: Sat, 19 Aug 2006 19:52:25 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44E74FD9.7000507@flower.upol.cz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca> <1155822530.15195.95.camel@localhost.localdomain> <20060817143633.GF13641@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: 7eggert@gmx.de, Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060817143633.GF13641@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> 
> Hmm, so how does one tell hal to go to hell and leave the cdrom device
> alone at all times (other than totally disabling hal).

AFAIK many drivers allow multiple opening of device files. If programs do not
honor any kind of locking (advisory, O_EXCL) use mandatory locking (DOS 2.0
compatibility, no problems ;)

> Who the heck wants all that stupid auto crap anyhow. :)
>
Yea. But see RH managers on its videos, happy about usb sticks being plugged
and worked, he-he:
<http://www.redhat.com/v/magazine/mov/005_BehindScenes_RHEL4.mov>.

I've just installed debian-gnu and got all that
cpufrequtils, powermgmt, acpiutils installed on amd64 laptop
while i just need:
,-
|modprobe powernow-k8
|modprobe cpufreq_ondemand
|echo ondemand >scailing_governor
`-
Anyway long, almost 10 years, way to win95 and win98 is never ending ;D

--
-o--=O`C  /. .\ (???)  (+)                                    /o o\
  #oo'L O      o         |                                     o.
<___=E M    ^--         |  (you're barking up the wrong tree) =--'

