Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUGDKzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUGDKzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUGDKzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:55:32 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:52466 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265633AbUGDKzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:55:08 -0400
Message-ID: <297f4e0104070403553efe6821@mail.gmail.com>
Date: Sun, 4 Jul 2004 12:55:07 +0200
From: Ikke <ikke.lkml@gmail.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: 4K vs 8K stacks- Which to use?
Cc: linux-kernel@vger.kernel.org, ap@solarrain.com
In-Reply-To: <Pine.LNX.4.60.0407030649120.13543@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.60.0407030649120.13543@p500>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a P2 here, and got some problems that *could* be related to 4k stacks.
I'm running 2.6.7-redeeman3 now (i.e. 2.6.7-mm3+reiser4+nick's sheduler).
If I configure it using 4k stacks and APM as module (not loaded) I get
crashes (Page Faults I think). Same configuration, but 4k stacks
disabled and APM module disabled, runs stable.

Just for your interest ;)

Regards, Ikke

On Sat, 3 Jul 2004 06:50:58 -0400 (EDT), Justin Piszcz
<jpiszcz@lucidpixels.com> wrote:
> I use an array of machines with all sorts of CPU's (but no 64bit CPU's
> yet):
> 
> Which should I use for each CPU?
> Which is better and why?
> 
> Pentium 1 CPU's
> Cyrix P150 (120MHZ)
> Pentium 2 CPU's
> Pentium 3 CPU's
> Pentium 4 W/HT
> Pentium 4 W/OUT HT
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
