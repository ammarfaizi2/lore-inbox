Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSG3KGt>; Tue, 30 Jul 2002 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSG3KGt>; Tue, 30 Jul 2002 06:06:49 -0400
Received: from dsl-213-023-043-226.arcor-ip.net ([213.23.43.226]:65179 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317636AbSG3KGt>;
	Tue, 30 Jul 2002 06:06:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 1/13] misc fixes
Date: Tue, 30 Jul 2002 12:11:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D439E09.3348E8D6@zip.com.au> <E17Z4v0-0002io-00@starship> <3D459ECE.C5BD53DE@zip.com.au>
In-Reply-To: <3D459ECE.C5BD53DE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ZTyP-0001hR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 22:00, Andrew Morton wrote:
> Anton did some testing on a 4-way PPC.  Similar results, I think.
> As an experiment he added a spinlock to the page structure and used
> that instead of the PG_chainlock flag.  It helped a lot.  He thinks
> that is because their spin_unlock() is not buslocked (like ia32).

So what happened when you tried that on your machine?

-- 
Daniel
