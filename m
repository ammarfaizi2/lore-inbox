Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTIYKO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbTIYKO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:14:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13548 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261782AbTIYKO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:14:26 -0400
Date: Thu, 25 Sep 2003 03:01:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Joe Perches <joe@perches.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] 2.6.0-bk6 net/core/dev.c
Message-Id: <20030925030109.09bbedca.davem@redhat.com>
In-Reply-To: <1064423867.15283.11.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0309241012110.3178-100000@home.osdl.org>
	<1064423867.15283.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003 10:17:47 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2003-09-24 at 10:13, Linus Torvalds wrote:
> > Looks sane, but wouldn't it be cleaner to put this ugly special case logic
> > with casts etc in an inline function and make the code a bit more readable
> > at the same time?
> 
> I've got those.
> 
> I've done the ((void*)1) conversions to PKT_SHARED_SKBs
> and found this missing.  I'll submit those separately.

Send me what you have and I'll review and apply it.

I haven't accomplished anything today because I've been sick,
but tomorrow I should be back to full speed once more.
