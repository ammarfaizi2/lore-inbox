Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSFTCFU>; Wed, 19 Jun 2002 22:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318093AbSFTCFT>; Wed, 19 Jun 2002 22:05:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32499 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318092AbSFTCFS>; Wed, 19 Jun 2002 22:05:18 -0400
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20020619.185514.52961715.davem@redhat.com>
References: <3D11245F.DB13A07C@mvista.com>
	<20020619.183432.27032473.davem@redhat.com> <1024538005.922.70.camel@sinai>
	 <20020619.185514.52961715.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 19:05:11 -0700
Message-Id: <1024538711.921.85.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 18:55, David S. Miller wrote:

> What about all of the serial driver BHs?  You keep avoiding this
> issue.

Because I was told rmk's serial rewrite ditched old-style BHs...

> Also, when people remove *_BH they should remove the define in
> include/linux/interrupt.h Why people leave this there is beyond me, it
> only causes confusion when people try to figure out what the current
> state of affairs is.

I agree.

	Robert Love

