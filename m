Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTEJT5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTEJT5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:57:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9856 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S264490AbTEJT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:57:49 -0400
Subject: Re: hammer: MAP_32BIT
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030510014803.GA16407@averell>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell>
	 <3EBBE7E2.1070500@redhat.com>  <20030510014803.GA16407@averell>
Content-Type: text/plain
Organization: 
Message-Id: <1052597418.1881.2.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sat, 10 May 2003 21:10:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-10 at 02:48, Andi Kleen wrote:
> > Oh, and please rename MAP_32BIT to MAP_31BIT.  This will save nerves on
> > all sides.
> 
> I bet changing it will cost more nerves in supporting all these people
> whose software doesn't compile anymore. And it's not really a lie. 2GB 
> is 32bit too.

If that's _really_ an issue, then also provide MAP_32BIT which does what
its name implies. 

Anyone who was using MAP_32BIT in the knowledge that it really limits to
31 bits gets the breakage they deserve for not reporting and fixing the
problem at the time.

-- 
dwmw2

