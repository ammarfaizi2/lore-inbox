Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131198AbRCGXZ3>; Wed, 7 Mar 2001 18:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbRCGXZO>; Wed, 7 Mar 2001 18:25:14 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:60583 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131198AbRCGXYF>; Wed, 7 Mar 2001 18:24:05 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200103072323.f27NNYl21255@devserv.devel.redhat.com>
Subject: Re: [PATCH] RFC: fix ethernet device initialization
To: andrewm@uow.edu.au (Andrew Morton)
Date: Wed, 7 Mar 2001 18:23:34 -0500 (EST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Knernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), alan@redhat.com (Alan Cox),
        davem@redhat.com (David S. Miller), netdev@oss.sgi.com,
        arjan@fenrus.demon.nl (Arjan van de Ven)
In-Reply-To: <3AA6C080.99D35298@uow.edu.au> from "Andrew Morton" at Mar 07, 2001 11:13:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It'll only take a few days.  Do we want?  If not, we can
> extend the dev_probe_lock() thing to cover probes for
> other busses.  USB, I guess.

cardbus.. usb.. insmod/rmmod

I'd like it fixed, but you have to convince DaveM
