Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTI3HHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTI3HHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:07:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24325 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263135AbTI3HHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:07:07 -0400
Date: Tue, 30 Sep 2003 00:03:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930000302.3e1bf8bb.davem@redhat.com>
In-Reply-To: <1064903562.6154.160.camel@imladris.demon.co.uk>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030929220916.19c9c90d.davem@redhat.com>
	<1064903562.6154.160.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 07:32:42 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2003-09-29 at 22:09 -0700, David S. Miller wrote:
> > For things inside the kernel, what ipv6 is doing is completely legal.
> > Changing your config setting in any way in the main kernel tree can
> > change just about anything else in the kernel, including the layout
> > of structures.
> 
> With boolean options that's fair enough. But changing any config option
> from 'n' to 'm' should not change anything in the main kernel. To do so
> is confusing and should be considered broken, as Adrian says.

This conflicts with the other reply you've made to me in this
thread where you say that you agree with me.

So which is it? :-)

I don't see why "enabling to 'y'" and "enabling to 'm'" are in any
way fundamentally different.  You're turning something on, therefore
something is going to change.

And when I see suggestions that we add four options to replace the
single one we have now, with a addendum saying "it's not really
complex, we'll explain it in the documentation", I want to pull my
hair out.

I would rather apply a patch that bloats up the structures than
subscribe to crazy ideas such as this four option one being proposed.
