Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKXXap>; Sun, 24 Nov 2002 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSKXXap>; Sun, 24 Nov 2002 18:30:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261900AbSKXXao>;
	Sun, 24 Nov 2002 18:30:44 -0500
Date: Sun, 24 Nov 2002 15:35:50 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Pavel Machek <pavel@ucw.cz>
cc: Martin Mares <mj@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-ram: don't crash when kernel gets big
In-Reply-To: <20021124225125.GA5115@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L2.0211241535050.21261-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002, Pavel Machek wrote:

| Hi!
|
| > > +	pushl	$0			# Kill any dangerous flags
| > > +	popfl
| > > +	cli
| > > +	cld
| >
| > Seems like you're trying to be 200% sure ;-)
|
| I was not sure if cli really *clears* it as name implies :-).

Yes, as Martin suggested.  8;)

-- 
~Randy

