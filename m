Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbSKAB3C>; Thu, 31 Oct 2002 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265573AbSKAB2N>; Thu, 31 Oct 2002 20:28:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22545 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265567AbSKAB1L>; Thu, 31 Oct 2002 20:27:11 -0500
Date: Thu, 31 Oct 2002 20:32:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "Matthew J. Fanto" <mattf@mattjf.com>, linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
In-Reply-To: <20021030200020.GV28982@clusterfs.com>
Message-ID: <Pine.LNX.3.96.1021031202931.22444C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Andreas Dilger wrote:

> Some notes:
> 1) having so many encryption algorithms is a huge pain in the ass, and
>    it will never be accepted into the kernel like that.  Pick some
>    "good" encryption algorithms (like those that will be supported as
>    part of IPSec and/or the encrypted loop devices: 3DES, AES, RC5 or
>    whatever) and then there can be some re-use with other parts of the kernel.

You are more trusting than I that these things can't be broken or in the
case of AES were not selected because they could. Your point is good, but
I think the way to do it is to define a crypto module API, such that user
could drop in his/her own, be it custom, something which pops up in a
year, or whatever.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

