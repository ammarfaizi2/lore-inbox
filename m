Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbTGIXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbTGIXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:25:57 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:64396 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S266205AbTGIXZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:25:56 -0400
Date: Wed, 9 Jul 2003 19:40:35 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22-pre3: P3 and P4 for chekc_gcc
Message-ID: <20030709234035.GI267@kurtwerks.com>
References: <20030709223355.GA2604@werewolf.able.es> <3F0C9EE8.2050005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0C9EE8.2050005@pobox.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Garzik:
> J.A. Magallon wrote:
> > 
> > ifdef CONFIG_MPENTIUMIII
> >-CFLAGS += -march=i686
> >+CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
> > endif

[...]

> I haven't had any problems at all, but I'm curious if anyone has any 
> negative feedback...  It's rather easy to be conservative and ignore the 
> patch, since -march=i686 should always work.

No problems over here. I've been running it since it was first submitted.

Kurt
-- 
If God had meant for us to be in the Army, we would have been born with
green, baggy skin.
