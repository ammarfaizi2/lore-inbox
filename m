Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278489AbRJPB6H>; Mon, 15 Oct 2001 21:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278492AbRJPB5s>; Mon, 15 Oct 2001 21:57:48 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:37124 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S278489AbRJPB5k>; Mon, 15 Oct 2001 21:57:40 -0400
Date: Mon, 15 Oct 2001 21:58:12 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: very slow RAID-1 resync
In-Reply-To: <Pine.LNX.4.33.0110151653120.13462-100000@windmill.gghcwest.com>
Message-ID: <Pine.LNX.4.10.10110152156570.25210-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> raid1d and raid1syncd are barely getting any CPU time on this otherwise
> idle SMP system.

I noticed this too, on a uni, raid5 system;
the resync-throttling code doesn't seem to work well.

