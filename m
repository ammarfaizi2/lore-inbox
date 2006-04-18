Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWDRUM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWDRUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDRUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:12:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:63618 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932310AbWDRUMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:12:25 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.
Date: Tue, 18 Apr 2006 22:12:13 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
References: <4444C0EA.mailKK411J5GA@suse.de> <20060418190528.GL11582@stusta.de>
In-Reply-To: <20060418190528.GL11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604182212.13835.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 21:05, Adrian Bunk wrote:
> On Tue, Apr 18, 2006 at 12:35:22PM +0200, Andi Kleen wrote:
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> >...
> 
> NAK.
> 
> When submitting a patch that is the revert of a patch that went 
> into Linus' tree just 8 days ago [1], I'd expect at least:
> - a Cc to the people involved with the patch you are reverting
> - a note that you are reverting a recent patch in your patch
>   description
> - an explanation why you disagree with the patch you are reverting

The subject was very clear. i386 options belong into arch/i386.

> If you disagree with a patch, please speak up when it's submitted or 
> discuss it after you've seen it in the tree. But don't play such silly
> revert-and-hope-they-don't-notice-I've-reverted-it games.

I moved it because I noticed that my x86-64 configuration files 
had this strange new symbol. I also did a grep and no other architecture
other than i386 uses it.

i386 specific hacks belong into arch/i386

-Andi (who actually thinks the whole thing was always a bad idea - saving
a few K but giving up such debugging is a poor trade off)
