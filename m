Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbSKPVGd>; Sat, 16 Nov 2002 16:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbSKPVGd>; Sat, 16 Nov 2002 16:06:33 -0500
Received: from tapu.f00f.org ([66.60.186.129]:17862 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267362AbSKPVGb>;
	Sat, 16 Nov 2002 16:06:31 -0500
Date: Sat, 16 Nov 2002 13:13:29 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mikael Olenfalk <mikael@netgineers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-xfs eating filehandles when compiled with gcc 3.2
Message-ID: <20021116211329.GB32407@tapu.f00f.org>
References: <20021115113505.GA27887@tapu.f00f.org> <000d01c28ca1$9ab8f0b0$0501a8c0@devnet.vodha>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c28ca1$9ab8f0b0$0501a8c0@devnet.vodha>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 01:22:03PM +0100, Mikael Olenfalk wrote:

> When using Gentoo 1.3 (which uses gcc-2.95.4+) I did not experience
> these problems even if the packages where almost the same versions
> (some packages changed while I was doing the transition).

You have a solution then:  don't use gcc 3.2 for the kernel.

> I really don't want to give up a GCC 3.2 built system with
> -march=athlon-xp since the build time for a kernel decreased by
> almost 90 seconds after a bootstrap. I.e. a system compiled with
> gcc3.2 compiled a kernel at 5 minutes and a gcc2.95.4+ system
> compiled the same kernel with the same .config in 6:27 minutes.

Use 2.95.4+ for the kernel and gcc 3.2+ for user-land then.


  --cw
