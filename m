Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUKCXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUKCXsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUKCXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:44:45 -0500
Received: from brown.brainfood.com ([146.82.138.61]:25472 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261997AbUKCXTL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:19:11 -0500
Date: Wed, 3 Nov 2004 17:18:57 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: DervishD <lkml@dervishd.net>
cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
In-Reply-To: <20041103152531.GA22610@DervishD>
Message-ID: <Pine.LNX.4.58.0411031718320.1229@gradall.private.brainfood.com>
References: <200411030751.39578.gene.heskett@verizon.net>
 <20041103143348.GA24596@outpost.ds9a.nl> <yw1xis8nhtst.fsf@ford.inprovide.com>
 <20041103152531.GA22610@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, DervishD wrote:

>     Hi all :)
>
>  * Måns Rullgård <mru@inprovide.com> dixit:
> > >> I'd tried to kill the zombie earlier but couldn't.
> > >> Isn't there some way to clean up a &^$#^#@)_ zombie?
> > > Kill the parent, is the only (portable) way.
> > Perhaps not as portable, but another possible, though slightly
> > complicated, way is to ptrace the parent and force it to wait().
>
>     Or write a little program that just 'wait()'s for the specified
> PID's. That is perfectly portable IMHO. But I must admit that the
> preferred way should be killing the parent. 'init' will reap the
> children after that.

ptrace the parent, cause it to wait() for it's children, then change IP, etc.

