Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSLBHTZ>; Mon, 2 Dec 2002 02:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLBHTY>; Mon, 2 Dec 2002 02:19:24 -0500
Received: from angband.namesys.com ([212.16.7.85]:50055 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265564AbSLBHSo>; Mon, 2 Dec 2002 02:18:44 -0500
Date: Mon, 2 Dec 2002 10:26:07 +0300
From: Oleg Drokin <green@namesys.com>
To: Colin Slater <hoho@tacomeat.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs broken in 2.5.50 (possibly nanosecond stat timefields?)
Message-ID: <20021202102607.A18532@namesys.com>
References: <20021130.140719.92588041.hoho@tacomeat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021130.140719.92588041.hoho@tacomeat.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Nov 30, 2002 at 02:07:19PM -0500, Colin Slater wrote:

> > I just tested it and reiserfs works fine here with 2.5.50 with some
> > simple stress tests.
> > Are you sure you loaded the right modules? The new modutils don't 
> > do any kernel version checking anymore.
> Patch from Oleg Drokin fixes this, absolving you from any
> responsibility. Sorry to randomly pick a patch and mark it evil.  I'm
> not sure why I needed this and you (and I assume others) didn't
> though. Oleg probably knows.
> 

That's not my patch. It is fs/namei.c patch from
SL Baur <steve@kbuxd.necst.nec.co.jp>
And of course everybody needs that patch for 2.5.50.

Bye,
    Oleg
