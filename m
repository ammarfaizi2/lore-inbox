Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSDYReh>; Thu, 25 Apr 2002 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSDYReg>; Thu, 25 Apr 2002 13:34:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61201 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313187AbSDYReg>;
	Thu, 25 Apr 2002 13:34:36 -0400
Date: Thu, 25 Apr 2002 19:34:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020425173439.GM3542@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net> <3CC66794.5040203@evision-ventures.com> <20020424091151.GD812@suse.de> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25 2002, Jens Axboe wrote:
> - Make the ata_request the general means of passing down request in the
>   IDE layer -- start by making hwgroup->rq into hwgroup->ar and _never_
>   store ar in ->special (you don't have to, you will always just go from
>   ar -> rq, which is of course ar->ar_rq). This is what I wanted to do.

I'll do this on monday, I'm away friday and through the weekend. Lets
get this fixed _properly_.

-- 
Jens Axboe

