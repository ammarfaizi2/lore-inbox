Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVBGMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVBGMpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVBGMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:45:18 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:33758 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261409AbVBGMpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:45:12 -0500
Date: Mon, 7 Feb 2005 13:45:02 +0100
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207124502.GD1673@ojjektum.uhulinux.hu>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <4207104C.1000604@tequila.co.jp> <20050207112914.GB2686@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207112914.GB2686@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 12:29:14PM +0100, Andries Brouwer wrote:
> and (ii) sometimes several types would succeed (e.g. msdos/vfat)
> and the user can override the kernel order.

But we are talking about the default order.


> By the way, it is best to consider the kernel order as undefined.

But it is not undefined, and if it is a well-defined order (and it is), 
then it should have a sane order.

> It is not true that vfat is universally better than msdos.
> Some need one, some need the other.

> Finally, guessing is always bad. It is convenient in the short run
> but may lead to crashes and data loss in the long run.

Well, it can be bad, maybe it should be avoided. But if someone wants 
guessing, why not provide him a (imho) more reasonable order of 
guessing? I do think vfat should be tried first. If you are doing for 
example some kind of recovery you wont bet on autoguessing. But if you 
just want to use it, use might, and in that case you want long 
filenames, ie vfat.


-- 
pozsy
