Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRJZClr>; Thu, 25 Oct 2001 22:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277347AbRJZClh>; Thu, 25 Oct 2001 22:41:37 -0400
Received: from zero.tech9.net ([209.61.188.187]:16394 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277338AbRJZCl1>;
	Thu, 25 Oct 2001 22:41:27 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: Robert Love <rml@tech9.net>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004060759.11258.12.camel@phantasy>
	<6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004061741.11366.32.camel@phantasy> 
	<g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 25 Oct 2001 22:42:04 -0400
Message-Id: <1004064125.19937.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 22:36, Tachino Nobuhiro wrote:
>   No. {0, } is the last elemnet of ac97_codec_ids[] and that index is
> ARRAY_SIZE(ac97_code_ids) - 1. So this element which should be used as
> a loop terminator is used as a valid entry in for loop incorrectly. 
> 
> Please read ac97_codec.c

You are right; I apologize.

	Robert Love

