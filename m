Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285079AbRLMTpb>; Thu, 13 Dec 2001 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285117AbRLMTpV>; Thu, 13 Dec 2001 14:45:21 -0500
Received: from mustard.heime.net ([194.234.65.222]:3040 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285079AbRLMTpE>; Thu, 13 Dec 2001 14:45:04 -0500
Date: Thu, 13 Dec 2001 20:44:39 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.30.0112132003280.27508-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.30.0112132041260.27734-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This gives a total read of a little less than 800MB before giving up. Is
> there a cache timeout that needs to be set any lower?
>
> roy

more testing

[root@linuxserver root]# swapoff -a
[root@linuxserver root]# free
             total       used       free     shared    buffers     cached
Mem:        899712      74504     825208          0       4832      29408
-/+ buffers/cache:      40264     859448
Swap:            0          0          0
[root@linuxserver root]# vmstat -n 2

blah blah blah

same result.
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


