Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbTFYW65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFYW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:57:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265166AbTFYW5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:57:01 -0400
Subject: Re: patch O1int for 2.5.73 - interactivity work
From: Andy Pfiffer <andyp@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <1056577981.603.3.camel@teapot.felipe-alfaro.com>
References: <200306260209.45020.kernel@kolivas.org>
	 <1056577981.603.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056582622.1200.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Jun 2003 16:10:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 14:53, Felipe Alfaro Solana wrote:
> On Wed, 2003-06-25 at 18:09, Con Kolivas wrote:
> > Hi all 
> > 
> > I've used the corner cases described that cause a lot of the interactivity 
> > problems to develop this patch.

> This patch is indeed much better than the ones posted before. In fact,
> it's really, really hard for me to make XMMS skip audio. It feels much
> better in general, but there are still some rough edges when the system
> is under load. For example, the mouse cursor on an X session doesn't
> move smoothly, and feels a little jumpy. It can be somewhat fixed by
> renicing the X server to -20.

I'm running with this patch on my dual-proc desktop right now.

I agree: with a make -j20 going, the mouse became non-responsive
for about 1 second at a time.  Renicing the X server to -20 greatly
improved the response of my desktop with this patch under load.

I could switch virtual desktops (blackbox), move the mouse to focus on
an aterm and type a command (and get a response back), and not wait
too long for evolution to repaint or open a piece of email.

I could tell that something was grinding away on my system, but it was
still tolerable.

Andy


