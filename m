Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWHBWL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWHBWL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWHBWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:11:25 -0400
Received: from mail.suse.de ([195.135.220.2]:35249 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932267AbWHBWLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:11:24 -0400
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: WARN_ON causes recursive unwind panic
Date: Thu, 3 Aug 2006 00:11:15 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060802145945.5d24e126@localhost.localdomain>
In-Reply-To: <20060802145945.5d24e126@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030011.15871.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 23:59, Stephen Hemminger wrote:

> [ 4202.665764]  [<ffffffff8103440e>] run_timer_softirq+0x147/0x1d0
> [ 4202.683541]  [<ffffffff81030bc0>] __do_softirq+0x67/0xf4
> [ 4202.699506]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28

That is already fixed and submitted, but L. hasn't merged the patch yet.

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/entry-more-unwind

Also please cc Jan Beulich <jbeulich@novell.com> with unwinder problems.

-Andi
