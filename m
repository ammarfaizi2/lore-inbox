Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSKILPF>; Sat, 9 Nov 2002 06:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264693AbSKILPF>; Sat, 9 Nov 2002 06:15:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20181 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264683AbSKILPE>;
	Sat, 9 Nov 2002 06:15:04 -0500
Date: Sat, 9 Nov 2002 12:21:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021109112135.GB31134@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211091426.54403.conman@kolivas.net> <3DCC8BCB.F5E39AB7@digeo.com> <200211091612.08718.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211091612.08718.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09 2002, Con Kolivas wrote:
> >You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
> >Maybe it doesn't translate to worsened interactivity.  Needs more
> >testing and anaysis.
> 
> Sounds fair enough. My resources are exhausted though. Someone else have any 
> thoughts?

Try setting lower elevator passover values. Something ala

# elvtune -r 64 /dev/hda

(or whatever your drive is)

-- 
Jens Axboe

