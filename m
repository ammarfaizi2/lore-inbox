Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWGQPV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWGQPV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWGQPV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:21:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29065 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750813AbWGQPV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:21:27 -0400
Date: Mon, 17 Jul 2006 17:21:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: gmu 2k6 <gmu2006@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607171718140.6762@scrub.home>
References: <20060714150418.120680@gmx.net>  <Pine.LNX.4.64.0607171242440.6761@scrub.home>
  <20060717133809.150390@gmx.net>  <Pine.LNX.4.64.0607171605500.6761@scrub.home>
 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jul 2006, gmu 2k6 wrote:

> I was preparing a post to lkml about a similar hang which happens
> during init. I also saw an error while ntpdate tried to set the
> time/get the time. this only happens after I've enabled the NX bit on
> the dual 32bit Xeons installed in the HP Proliant Server. it works
> flawlessly with 2.6.17.6 (CONFIG_X86_PAE and CONFIG_HIGHMEM_64) but
> since 2.6.18-rc2-git4 (including 2.6.18-rc2) it hangs late in the init
> process.
> 
> could this be related?

Well, it could, but without further information it's impossible to say.
What error did you see with ntpdate? Could you post the kernel messages 
and also insert a few stack traces as mentioned earlier?
Thanks.

bye, Rman
