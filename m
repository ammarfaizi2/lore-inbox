Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292922AbSBVQJJ>; Fri, 22 Feb 2002 11:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292923AbSBVQI7>; Fri, 22 Feb 2002 11:08:59 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:59015
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S292922AbSBVQIk>; Fri, 22 Feb 2002 11:08:40 -0500
Date: Fri, 22 Feb 2002 11:08:01 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Jes Sorensen <jes@trained-monkey.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Troy Benjegerdes <hozer@drgw.net>, <wli@holomorphy.com>,
        <torvalds@transmeta.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <15478.25001.512565.628500@trained-monkey.org>
Message-ID: <Pine.LNX.4.44.0202221107270.8753-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Jes Sorensen wrote:

> >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> Jeff> Jes Sorensen wrote:
> >> __mc68000__ is the correct define, I don't know who put in
> >> CONFIG_M68K but it doesn't belong there.
> 
> Jeff> I disagree -- look at arch/*/config.in.
> 
> Jeff> Each arch needs to define a CONFIG_$ARCH.
> 
> Why? CONFIG_$ARCH only makes sense if you can enable two architectures
> in the same build. What does CONFIG_M68K give you that __mc68000__
> doesn't provide?

Uniformity.


Nicolas

