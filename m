Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTIXRSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTIXRSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:18:18 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:27911 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S261542AbTIXRSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:18:17 -0400
Subject: Re: [PATCH] 2.6.0-bk6 net/core/dev.c
From: Joe Perches <joe@perches.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David S Miller <davem@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0309241012110.3178-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309241012110.3178-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1064423867.15283.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Sep 2003 10:17:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-24 at 10:13, Linus Torvalds wrote:
> Looks sane, but wouldn't it be cleaner to put this ugly special case logic
> with casts etc in an inline function and make the code a bit more readable
> at the same time?

I've got those.

I've done the ((void*)1) conversions to PKT_SHARED_SKBs
and found this missing.  I'll submit those separately.

