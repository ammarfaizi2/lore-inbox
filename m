Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUEBNyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUEBNyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEBNyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:54:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3326 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263088AbUEBNyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:54:32 -0400
Date: Sun, 2 May 2004 15:54:24 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Chris Wedgwood <cw@f00f.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, koke@amedias.org,
       linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502135424.GA20578@apps.cwi.nl>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501234444.GA24120@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501234444.GA24120@taniwha.stupidest.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 04:44:44PM -0700, Chris Wedgwood wrote:
> On Sun, May 02, 2004 at 01:24:48AM +0200, Petr Vandrovec wrote:
> 
> > (1) agetty (at least from util-linux 2.12 from current debian
> > unstable) opens /dev/console and calls VT_OPENQRY to find first
> > unopened VT.
> 
> yes, this i discovered too

Thank you for cc-ing me.
However, my agetty source does not contain the string VT_OPENQRY.
I suppose this is a private Debian change. Maybe you should
contact Debian people to find out who did this and why.
(And/or try the vanilla agetty to see whether the problems go away.)

Andries


[Just found the Debian patch. Strange, broken code.]
