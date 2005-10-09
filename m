Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVJIBG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJIBG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 21:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJIBG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 21:06:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57804 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932201AbVJIBG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 21:06:27 -0400
Date: Sun, 9 Oct 2005 02:06:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] gfp flags annotations
Message-ID: <20051009010625.GF7992@ftp.linux.org.uk>
References: <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org> <20051009011315.GA7682@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009011315.GA7682@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 05:13:15AM +0400, Alexey Dobriyan wrote:
> On Sat, Oct 08, 2005 at 04:34:36PM -0700, Linus Torvalds wrote:
> > On Thu, 6 Oct 2005, Al Viro wrote:
> > > a) typedef unsigned int __nocast gfp_t;
> >
> > Btw, since you did a typedef, any reason why it isn't marked __bitwise
> > too? It would seem that all valid uses of it are bit tests with predefined
> > values, ie a __bitwise restriction would seem very natural, no?
> 
> See [*] in Al's RFC.
> 
> The amount of endian warnings on allmodconfig is in >10K range. gfp_t
> ones would simply be lost in noise.

I've done that in the latter chunks, will send the next few in about half an
hour...
