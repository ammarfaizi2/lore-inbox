Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTKRHKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 02:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKRHKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 02:10:17 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:63756 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262353AbTKRHKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 02:10:13 -0500
Date: Tue, 18 Nov 2003 15:11:26 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO build modules in 2.6.0 ...
In-Reply-To: <20031118055007.GC1008@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33.0311181510020.373-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Sam Ravnborg wrote:

> On Mon, Nov 17, 2003 at 11:59:27PM +0000, John Levon wrote:
> > On Mon, Nov 17, 2003 at 09:33:36PM +0100, Sam Ravnborg wrote:
> >
> > > Use the following:
> > > make -C /usr/src/linux SUBDIRS=`pwd` O=/users/cieciwa/rpm/BUILD/eagle-1.0.4/linux modules
> > >
> >
> > This requires a kernel source tree empty of built files though, so it's
> > really not a great solution ...
>
> Correct - but why keep kernel trees around full of build files, when
> there is a proper solution to keep them out of the src.
>
> The problem was generated files. If a generated file were present in
> the kernel source tree, it would not be built again.
> This resulted in a few suprises during development, and I therefore
> added the check for a kernel source tree with no built-files.
> It can be avoided, but that required too much surgery in various
> makefiles and include statements. So that part is 2.7 material.

And this method works for versioned kernels as well without having to
build a new kernel?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

