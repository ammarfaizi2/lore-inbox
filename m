Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHRWvB>; Sun, 18 Aug 2002 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHRWvB>; Sun, 18 Aug 2002 18:51:01 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:16070 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S316512AbSHRWvB>; Sun, 18 Aug 2002 18:51:01 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020818184135.66fe0ba2.arodland@noln.com>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode>
	<6un0rkuiyg.fsf@zork.zork.net> <1029695363.1357.5.camel@psuedomode> 
	<20020818184135.66fe0ba2.arodland@noln.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 18:55:02 -0400
Message-Id: <1029711302.3331.35.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 18:41, Andrew Rodland wrote:
> On 18 Aug 2002 14:29:23 -0400
> Ed Sweetman <safemode@speakeasy.net> wrote:
> 
> > I know i have no device nodes.  I removed them all before installing
> > devfs.  
> 
> Well then you have no device nodes without devfs. D'uh? :)
> 
> > the devfs documentation says it doesn't need to have devfs
> > mounted to work, but this doesn't seem to be true at all.
> 
> No, the devfs documentation says that it is "safe" to have devfs
> compiled in and not use it -- you will just use the standard /dev. It
> does not imply in any way that you will be using devfs if you don't
> mount it, it says that if you choose _not_ to use devfs, then it will be
> able to fall cleanly back to standard /dev. In other words,
> CONFIG_DEVFS_FS provides the _ability_ to use devfs, not a
> _requirement_. 
> 
> That's all it says.
> To assume that it means anything else would be incredibly silly.

ok, so that's over and done with.   It's not the topic of the thread and
i've already fixed things a while ago.  

