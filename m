Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318096AbSFTCPm>; Wed, 19 Jun 2002 22:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSFTCPl>; Wed, 19 Jun 2002 22:15:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47093 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318096AbSFTCPk>; Wed, 19 Jun 2002 22:15:40 -0400
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20020619.190147.38450820.davem@redhat.com>
References: <1024538005.922.70.camel@sinai>
	<20020619.185514.52961715.davem@redhat.com> <1024538711.921.85.camel@sinai>
	 <20020619.190147.38450820.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 19:15:34 -0700
Message-Id: <1024539334.917.110.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 19:01, David S. Miller wrote:

> That isn't in the tree now.  We can only make analsis of the patch
> based upon what is in 2.5.x right now, you can't base it on what
> might be added in the future.

Could there possibly be any interaction between SERIAL_BH and TIMER_BH?

I guess my stance is if each BH-removal patch figures out its
syncronization issues, each should be fine regardless of what the other
BHs do.

The timer_bh runs often but touches a comprehensible amount of data.

	Robert Love

