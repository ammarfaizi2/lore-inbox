Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbREOWCI>; Tue, 15 May 2001 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbREOWB7>; Tue, 15 May 2001 18:01:59 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:62456 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261620AbREOWBR>;
	Tue, 15 May 2001 18:01:17 -0400
Date: Tue, 15 May 2001 14:59:34 -0700
From: Chip Salzenberg <chip@valinux.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515145934.L3098@valinux.com>
In-Reply-To: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com> <Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, May 15, 2001 at 01:03:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to James Simmons:
> Graphics cards are the same way. Especially high end ones. They have pipes
> as well. For low end cards you can think of them as single pipeline cards
> with one pipe.

It still frosts my shorts that DRM (e.g. /dev/dri/card0) doesn't use
write().  It's a natural way to feed pipelines.  But no, it's a raft
of ioctl() calls.  *sigh*
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
