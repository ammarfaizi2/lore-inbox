Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTCJTpa>; Mon, 10 Mar 2003 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTCJTpa>; Mon, 10 Mar 2003 14:45:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261440AbTCJTp3>;
	Mon, 10 Mar 2003 14:45:29 -0500
Date: Mon, 10 Mar 2003 19:56:10 +0000
From: Matthew Wilcox <willy@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: ioctl32 cleanup -- rest of architectures
Message-ID: <20030310195610.GJ5278@parcelfarce.linux.theplanet.co.uk>
References: <20030310172832.GG5278@parcelfarce.linux.theplanet.co.uk> <20030310185647.GA11310@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310185647.GA11310@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 07:56:47PM +0100, Pavel Machek wrote:
> So I should take arch/parisc/kernel/syscall.S and change
> ENTRY_DIFF(ioctl) into ENTRY_COMP(ioctl)? Great, thanx.

Exactly.

> [BTW have you actually tested it or are these just first obvious
> mistakes?]

I haven't tested it... no convenient 64-bit box at present.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
