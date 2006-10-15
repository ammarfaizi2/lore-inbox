Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWJOOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWJOOOk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160995AbWJOOOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 10:14:40 -0400
Received: from vstglbx99.vestmark.com ([208.50.5.99]:18183 "EHLO
	texas.hq.viviport.com") by vger.kernel.org with ESMTP
	id S1160994AbWJOOOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 10:14:39 -0400
Date: Sun, 15 Oct 2006 10:14:37 -0400
From: nmeyers@vestmark.com
To: Mike Galbraith <efault@gmx.de>
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Message-ID: <20061015141437.GA29712@viviport.com>
References: <20061013004918.GA8551@viviport.com> <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com> <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com> <1160899154.5935.19.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160899154.5935.19.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 15 Oct 2006 14:14:38.0114 (UTC) FILETIME=[3F9AC020:01C6F064]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 07:59:14AM +0000, Mike Galbraith wrote:
> On Fri, 2006-10-13 at 12:59 +0100, Catalin Marinas wrote:
> > On 13/10/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
> > > > If anyone has a version of kmemleak that I can build with 4.1.1, or
> > > > any other suggestions for instrumentation, I'd be happy to gather more
> > > > data - the problem is very easy for me to reproduce.
> 
> 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
> CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
> runs a lot faster ;-)  I'll try a stripped down config sometime.
> 
> 	-Mike

Thanks for digging that up - I'm building gcc now and will let you
know if any useful info emerges.

Nathan
