Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWJOR3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWJOR3b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWJOR3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:29:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:6103 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750875AbWJOR3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:29:30 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: nmeyers@vestmark.com
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061015141437.GA29712@viviport.com>
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
	 <20061015141437.GA29712@viviport.com>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 17:59:58 +0000
Message-Id: <1160935198.6007.14.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-15 at 10:14 -0400, nmeyers@vestmark.com wrote:
> On Sun, Oct 15, 2006 at 07:59:14AM +0000, Mike Galbraith wrote:
> > On Fri, 2006-10-13 at 12:59 +0100, Catalin Marinas wrote:
> > > On 13/10/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > > On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
> > > > > If anyone has a version of kmemleak that I can build with 4.1.1, or
> > > > > any other suggestions for instrumentation, I'd be happy to gather more
> > > > > data - the problem is very easy for me to reproduce.
> > 
> > 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
> > CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
> > runs a lot faster ;-)  I'll try a stripped down config sometime.
> > 
> > 	-Mike
> 
> Thanks for digging that up - I'm building gcc now and will let you
> know if any useful info emerges.

Buyer beware of course ;-)

	-Mike

