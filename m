Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281873AbRKSBq4>; Sun, 18 Nov 2001 20:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281872AbRKSBqs>; Sun, 18 Nov 2001 20:46:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281873AbRKSBqm>; Sun, 18 Nov 2001 20:46:42 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
Date: 18 Nov 2001 17:46:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9t9o91$k6p$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111181540190.16977-100000@netfinity.realnet.co.sz> <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Sun, 18 Nov 2001, Zwane Mwaikambo wrote:
> 
> > Is there any reason why the F0 0F bug check isn't in bugs.h?
> 
> hpa moved it (And some others) during his 2.3.99 big cleanup of setup.c
> and friends.
> 

bugs.h should die, ideally.  There is no good reason the checking for
features and the checking for bugs is done using different mechanisms,
and the bugs.h mechanism is *MUCH* uglier.  However, I was planning to
wait for 2.5 with that one.

     -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
