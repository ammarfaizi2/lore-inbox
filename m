Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRCYQmA>; Sun, 25 Mar 2001 11:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbRCYQlv>; Sun, 25 Mar 2001 11:41:51 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:9345 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S132109AbRCYQlm>;
	Sun, 25 Mar 2001 11:41:42 -0500
Message-Id: <l03130323b6e3cf66c12d@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.30.0103251754300.13864-100000@fs131-224.f-secure.com>
In-Reply-To: <01032411110700.03927@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 17:39:30 +0100
To: Szabolcs Szakacsits <szaka@f-secure.com>,
        Jesse Pollard <jesse@cats-chateau.net>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[ .... about non-overcommit .... ]
>> > Nobody feels its very important because nobody has implemented it.
>
>Enterprises use other systems because they have much better resource
>management than Linux -- adding non-overcommit wouldn't help them much.
>Desktop users, Linux newbies don't understand what's
>eager/early/non-overcommit vs lazy/late/overcommit memory management
>[just see these threads here if you aren't bored already enough ;)] and
>even if they do at last they don't have the ability to implement it. And
>between them, people are mostly fine with ulimit.
>
>> Small correction - It was implemented, just not included in the standard
>> kernel.
>
>Please note, adding optional non-overcommit also wouldn't help much
>without guaranteed/reserved resources [e.g. you are OOM -> appps, users
>complain, admin login in and BANG OOM killer just killed one of the
>jobs]. This was one of the reasons I made the reserved root memory
>patch [this is also the way other OS'es do]. Now just the different
>patches should be merged and write an OOM FAQ for users how to avoid,
>control, etc it].

I'm currently trying to apply the 2.3.99.whatever non-overcommit patch to
2.4.1 - decidedly nontrivial, lots of failed hunks, parts of the kernel
have changed significantly even in this (fairly short) time.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


