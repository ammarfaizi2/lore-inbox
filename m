Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263059AbTCWN0M>; Sun, 23 Mar 2003 08:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbTCWN0M>; Sun, 23 Mar 2003 08:26:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7142 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263059AbTCWN0L>; Sun, 23 Mar 2003 08:26:11 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303231337.h2NDbGP01132@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.65-ac3
To: gmack@innerfire.net (Gerhard Mack)
Date: Sun, 23 Mar 2003 08:37:16 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), jgarzik@pobox.com (Jeff Garzik),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303222221400.13256-100000@innerfire.net> from "Gerhard Mack" at Mar 22, 2003 10:23:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How close are IDE and vt switching to working with preempt ?

2.5 IDE probably does in 2.5 now, although I don't trust the
reset paths with it yet. Its just part of all the IDE debugging
and locking fixing that has to be done and will gradually
improve over time.

Its not a technical issue with pre-empt any more afaik.
