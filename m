Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287950AbSAHGob>; Tue, 8 Jan 2002 01:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287952AbSAHGoW>; Tue, 8 Jan 2002 01:44:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65297 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287950AbSAHGoN>;
	Tue, 8 Jan 2002 01:44:13 -0500
Date: Tue, 8 Jan 2002 07:43:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Message-ID: <20020108074350.Q1755@suse.de>
In-Reply-To: <20020104094334.N8673@suse.de> <20020105133800.A37@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020105133800.A37@toy.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05 2002, Pavel Machek wrote:
> Hi!
> 
> > I've played around with implementing an I/O scheduler that _tries_ to
> > start request within a given time limit. Note that it makes no
> > guarentees of any sort, it's simply a "how does this work in real life"
> > sort of thing. It's main use is actually to properly extend the i/o
> > scheduler / elevator api to be able to implement more advanced
> > schedulers (eg cello).
> 
> Would it be possible to introduce concept of I/O priority? I.e. I want 
> updatedb not to load disk if I need it for something else?

I've been toying with equal i/o distribution between the processes in
the system, but it isn't done yet. I know Arjan is working on a priority
scheduler, too. So something is bound to materialize sooner or later :)

-- 
Jens Axboe

