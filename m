Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWABM0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWABM0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWABM0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:26:01 -0500
Received: from mail.gmx.de ([213.165.64.21]:24239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932248AbWABM0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:26:00 -0500
X-Authenticated: #5082238
Date: Mon, 2 Jan 2006 13:26:07 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
Message-ID: <20060102122607.GB29275@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <43B90A04.2090403@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <43B90A04.2090403@conterra.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did not read (and find) your original posting, but it appears to me
that your problem is similar to mine. I upgraded to 4GB RAM on X86_64
and after that my Intel Gigabit card stopped working.
http://lkml.org/lkml/2005/12/19/144

Perhaps the higher class Gigabit cards need some memory area that is
(once) overwritten with 4GB main memory? I have no clue, actually :)

> eth0: 3Com Gigabit LOM (3C940)
>       PrefPort:A  RlmtMode:Check Link State

Did you try the ethtool tests? They show more information, at least with
my card.

> don't know, if it's related to that, but with 2G it runs stable since about 
> a year.

Does the problem still occur with 2GB (less)? Did you try running
Knoppix? The latter solves the problem here, but obviously Knoppix is no
final solution.

> The problem arises as soon as my network (3C940) gets enabled, the following
> message is continuously repeated and nothing else works any more, not even
> console switching.

Wow.
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
