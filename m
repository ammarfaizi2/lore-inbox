Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSJANcv>; Tue, 1 Oct 2002 09:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbSJANcv>; Tue, 1 Oct 2002 09:32:51 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:34182 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S261631AbSJANct>; Tue, 1 Oct 2002 09:32:49 -0400
Message-ID: <3D99A53D.2090008@attbi.com>
Date: Tue, 01 Oct 2002 08:38:05 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] problem with 2.5.x and X
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I have been having some strange problems with X for a while in 2.5.x 
(I started noticing them around 2.5.33 or 2.5.35 I believe) but I was 
having other problems as well so I waited for those to go away in hope 
that the problems with X would as well.  The other problems I was seeing 
are gone with 2.5.39-bk from last night, but my problems with X are 
still here.  Here they are:

1) Whether I have a frame buffer active or not I can not log into a gdm 
session and then lof out without my machine completely locking up when 
it gets back to the gdm screen, no sysrq, no nothing.

2) If a framebuffer is active I cannot even switch between VTs and my X 
session using ctrl-alt-f<vt> without the same lockup as above happening.

I don't really know what is causing this since I though it might have 
been the framebuffer/console stuff but not using the framebuffer only 
fixes part of the problem not the whole thing so I now think that the 
framebuffer code simply makes the problem more noticeable.

My machine is a dual cpu Athlon (Athlon MPs) with 1 GB and only scsi 
drives.  It has smp, preempt, and highmem enabled in the config.  Please 
let me know if you need more info to try and figure out what is going on.

Jordan Breeding

