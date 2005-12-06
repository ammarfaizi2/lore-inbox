Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVLFSCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVLFSCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLFSBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:01:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:45548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964989AbVLFSB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:29 -0500
Date: Tue, 6 Dec 2005 09:47:14 -0800
From: Greg KH <greg@kroah.com>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206174714.GE3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <87psoapa8t.fsf@mid.deneb.enyo.de> <6f6293f10512060855p79fb5e91ke6fca33f96cb1750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6293f10512060855p79fb5e91ke6fca33f96cb1750@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 05:55:42PM +0100, Felipe Alfaro Solana wrote:
> > There might be some subtle changes in the netfilter/routing
> > interaction which break user configurations, but this still being
> > tracked down (and maybe the any behavior is fine because it's
> > unspecified; hard to tell).
> 
> Yeah! For example, the first datagram triggering an IPSec SA is always
> lost (instead of being queued until the IPSec SA has been
> established).
> 
> For example, try pinging the IPSec SA peer for the very first time and
> the first ICMP datagram will always return "resource currently
> unavailable" and, of course, will get lost.
> 
> BTW this works perfectly under *BSD and Mac OS X.

Do the network kernel developers know about this issue?  And if so, what
have they said about it?

thanks,

greg k-h
