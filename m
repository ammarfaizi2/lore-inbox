Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbTAHBB3>; Tue, 7 Jan 2003 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267639AbTAHBB3>; Tue, 7 Jan 2003 20:01:29 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:65296 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267638AbTAHBB2>; Tue, 7 Jan 2003 20:01:28 -0500
Date: Wed, 8 Jan 2003 02:10:05 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
Message-ID: <20030108011005.GB25059@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030107232820.GB24664@merlin.emma.line.org> <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it> <20030108003050.GF17310@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108003050.GF17310@work.bitmover.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2003, Larry McVoy wrote:

> 
> > In very semplicistic words:
> > In 2.5/2.6 kernels, non GPL modules have a big
> > penalty, because they cannot create their own queue, but have to use a default
> > one.
> 
> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> drivers which ran in kernel mode but in the context of a process and had
> to talk to the real kernel via pipes or whatever.  It's a fair amount of
> plumbing but could have the advantage of being a more stable interface
> for the drivers. 

Some parts of the kernel have opened up for user space, think the
user-space file system efforts as one example.

