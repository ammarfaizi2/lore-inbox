Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSK0Eul>; Tue, 26 Nov 2002 23:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSK0Eul>; Tue, 26 Nov 2002 23:50:41 -0500
Received: from ns.suse.de ([213.95.15.193]:30728 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261581AbSK0Euk>;
	Tue, 26 Nov 2002 23:50:40 -0500
To: kuznet@ms2.inr.ac.ru
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
References: <Pine.LNX.4.33L2.0211261547450.2873-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel> <200211270042.DAA19185@sex.inr.ac.ru.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2002 05:57:58 +0100
In-Reply-To: kuznet@ms2.inr.ac.ru's message of "27 Nov 2002 01:49:57 +0100"
Message-ID: <p73lm3ftxrd.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru writes:

> > It would be OK with me not to accept such extensions.  :)
> 
> One of a few of extensions which does not cause any reaction
> but "it's strange that it was not in KR, apparently it was lost
> due to a buglet in the first parser" :-)

IMHO it's a bit dangerous. It even inspired me to my first gcc
patch, adding a warning for: 

	bla > 0 ? : somethingelse

(boolean expression as first argument) 

returning the boolean value for true which would be always 1. But the real 
intention was to return bla. I did this mistake at least twice. After that 
I decided to avoid this extension. Unfortunately the gcc guys ignored the patch
to warn for it.

-Andi
