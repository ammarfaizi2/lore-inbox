Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbUDQS6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbUDQS6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:58:35 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:34432
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263961AbUDQS6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:58:32 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040417183219.GB3856@flea>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org>  <20040417183219.GB3856@flea>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082228313.2580.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 11:58:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 11:32, Marc Singer wrote:
> On Sat, Apr 17, 2004 at 11:15:47AM -0700, Trond Myklebust wrote:
> > This sort of issue is precisely why I'd prefer to see people use TCP by
> > default. UDP with it's dependency on fragmentation works fine on fast
> > setups with homogeneous lossless networks. It sucks as soon as you break
> > one of those conditions.
> 
> I'd be glad to compare TCP to UDP on my system.  It's using an nfsroot
> mount.  It looks like the support is there.  What activates it?

It's all there. Just use the "tcp" mount option.

Cheers,
  Trond
