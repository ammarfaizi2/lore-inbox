Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTC1ESS>; Thu, 27 Mar 2003 23:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTC1ESS>; Thu, 27 Mar 2003 23:18:18 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:55293
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262190AbTC1ESR>; Thu, 27 Mar 2003 23:18:17 -0500
Date: Thu, 27 Mar 2003 23:25:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct slab cache use after free in 2.5.66
In-Reply-To: <20030327202348.75021c5d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303272323330.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
 <20030327202348.75021c5d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Andrew Morton wrote:

> That's the second report of this.  Someone did a put_task_struct against a
> freed task_struct.  I'll cook up a debug patch to trap it.  Something like
> this:

Well there is also the detach_pid bug which suddenly vanished... I'm not 
aware of anyone sending a patch for that (but i can't be certain i havent 
been keeping up with lkml lately). I posted some debug information for 
that one about a week ago:

Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com

Manfred?

-- 
function.linuxpower.ca
