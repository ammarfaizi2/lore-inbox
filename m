Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUFXNZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUFXNZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUFXNZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:25:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31154 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264461AbUFXNZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:25:10 -0400
Date: Tue, 22 Jun 2004 17:32:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: Egmont Koblinger <egmont@uhulinux.hu>, linux-kernel@vger.kernel.org
Subject: Re: information leak in vga console scrollback buffer
Message-ID: <20040622153231.GA698@openzaurus.ucw.cz>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu> <20040612204352.GA22347@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040612204352.GA22347@taniwha.stupidest.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Using the standard vga console, it is easily possible to read some
> > random pieces of texts that were scrolled out a long time ago (often
> > you can see your boot messages or similar stuff even after switcing
> > to another console or even to X. All you need is a local user access
> > to the console.
> 
> Feature not bug.

Read it again. Scrollback should be cleared by console switch,
but it can be recovered using obscure escape sequence.

Time for bugtraq?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

