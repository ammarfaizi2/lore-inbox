Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318662AbSHAHqy>; Thu, 1 Aug 2002 03:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318663AbSHAHqy>; Thu, 1 Aug 2002 03:46:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47080 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318662AbSHAHqy>;
	Thu, 1 Aug 2002 03:46:54 -0400
Date: Thu, 1 Aug 2002 09:49:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020801074953.GJ1644@suse.de>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01 2002, Marcelo Tosatti wrote:
> <akpm@zip.com.au> (02/08/01 1.663)
> 	[PATCH] disable READA

Since -rc5 is not to be found yet, I don't know what version of this
made it in. Is READA just being disabled on SMP, or was it the general
#if 0 change that got included? I'm asking since plain disabling READA
might have nasty performance effects. Andrew, I bet you did some numbers
on this, care to share?

-- 
Jens Axboe

