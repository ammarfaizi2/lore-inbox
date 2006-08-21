Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHUWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHUWJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWHUWJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:09:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:45279 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751241AbWHUWJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:09:05 -0400
Date: Tue, 22 Aug 2006 00:09:03 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-Id: <20060822000903.441acb64.ak@suse.de>
In-Reply-To: <20060821214636.GP11651@stusta.de>
References: <20060821212154.GO11651@stusta.de>
	<20060821232444.9a347714.ak@suse.de>
	<20060821214636.GP11651@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 23:46:36 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Aug 21, 2006 at 11:24:44PM +0200, Andi Kleen wrote:
> > On Mon, 21 Aug 2006 23:21:54 +0200
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > I got the following compile error with gcc 4.1.1 when trying to compile 
> > > kernel 2.6.18-rc4-mm2 for m68k:
> > 
> > I object to this change. -ffreestanding shouldn't be forced on everybody
> 
> Why?

Because -ffreestanding does the the wrong thing(tm) for the x86-64 
string implementation (which I plan to extend at some point to i386
too BTW). Don't argue with it -- what counts is not the name,
but the semantics.

-Andi
