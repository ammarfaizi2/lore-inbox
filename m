Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSBCW1N>; Sun, 3 Feb 2002 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287831AbSBCW05>; Sun, 3 Feb 2002 17:26:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11653 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287828AbSBCW0k>;
	Sun, 3 Feb 2002 17:26:40 -0500
Date: Mon, 4 Feb 2002 01:24:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Steffen Persvold <sp@scali.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <3C5DB730.B54B17B4@scali.com>
Message-ID: <Pine.LNX.4.33.0202040123540.19055-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Steffen Persvold wrote:

> OK, so are there any other way I can submit a block request from a
> tasklet (that is interrupt context, right ?) ?

submitting IO is something that needs a process context currently, ie. a
helper kernel thread.

	Ingo

