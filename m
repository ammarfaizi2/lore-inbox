Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUDSG3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbUDSG3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:29:21 -0400
Received: from holomorphy.com ([207.189.100.168]:27538 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263304AbUDSG3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:29:16 -0400
Date: Sun, 18 Apr 2004 23:29:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040419062914.GE743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418230131.285aa8ae.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 11:01:31PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc1/2.6.6-rc1-mm1/
> - All of the anonmm rmap work is now merged up.  No pte chains.
> - Various cleanups and fixups, as usual.
> - The list of external bk trees is getting a little short, due to problems
>   at bkbits.net.  The ones which are here are not necessarily very up-to-date
>   with the various development trees.

Okay, the cpumask_arith.h fixes aren't in here. What do I have to do to
get the bare minimal correctness fixes in this area propagated to mainline?

The important aspect of these is that they're pertinent to small SMP
systems, for instance, the dual Pee Cee shenanigans with all kinds of pins
clipped along with all the other things used in larger boxen castrated.


-- wli
