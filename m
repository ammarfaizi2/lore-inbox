Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWEWAUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWEWAUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWEWAUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:20:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:5347 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751200AbWEWAU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:20:29 -0400
From: Andi Kleen <ak@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: [PATCH] Consoldidate arch/{i386,x86_64}/boot/compressed/misc.c
Date: Tue, 23 May 2006 02:19:55 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4471FD34.8050202@gmx.net> <200605222028.32934.ak@suse.de> <44720BD2.7060809@gmx.net>
In-Reply-To: <44720BD2.7060809@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230219.56068.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 21:06, Carl-Daniel Hailfinger wrote:
> Andi Kleen wrote:
> 
> >> Would a series of incremental patches to consolidate these two
> >> subtrees get accepted?
> >>     
> >
> > Yes.
> >
> > I have some plans to change the 64bit boot up though - the uncompression
> > should already run as 64bit - but that shouldnt' affect these files.
> >   
> 
> Clean up arch/{i386,x86_64}/boot/compressed/misc.c a bit to reduce their
> differences. Should have zero effect on code generation.

Applied.

-Andi
