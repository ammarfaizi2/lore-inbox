Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSJTROS>; Sun, 20 Oct 2002 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbSJTROS>; Sun, 20 Oct 2002 13:14:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29612 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263276AbSJTROR>; Sun, 20 Oct 2002 13:14:17 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210201719.g9KHJeC21138@devserv.devel.redhat.com>
Subject: Re: workaround for Cyrix MediaGX/NSC Geode companion CS5510/5520 PIT latch bug
To: miura@da-cha.org (Hiroshi Miura)
Date: Sun, 20 Oct 2002 13:19:40 -0400 (EDT)
Cc: davej@suse.de, hpa@zytor.com, alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021017170344.0C87C11782A@triton2> from "Hiroshi Miura" at Oct 18, 2002 02:03:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with this patch, timejumps or timebacks don't occurs.
> This patch also removes dodgy_tsc() workaround.
> 
> this patch tried on mini note-PC CASSIOPEIA FIVA http://www.casio.co.jp/mpc/103/
> you can get spec from http://www.da-cha.org/fiva/fiva.html

Excellent. My wife has a 5520 based system and I can test it there too. Dave
if Windows always generates that delayed sequence (which btw the docs say
the delay is required...) it may explain the similar VIA weirdness

Alan
