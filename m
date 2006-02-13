Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWBMMS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBMMS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBMMS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:18:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58078 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932401AbWBMMS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:18:58 -0500
Date: Mon, 13 Feb 2006 13:18:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213035354.65b04c15.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602131315150.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu> <20060213035354.65b04c15.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Andrew Morton wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > your patch makes code larger on gcc3.
> 
> By 120 bytes here.  I dropped the patch.

Is this really worth it? This _is_ a compiler problem, are we going to add 
now const everywhere to work around a (small) compiler problem, which is 
already fixed in newer versions?

bye, Roman
