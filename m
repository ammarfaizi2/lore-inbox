Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUGZV65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUGZV65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUGZV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:58:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54918 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265823AbUGZV6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:58:55 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com, lenar@vision.ee,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040726203634.GA26096@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <20040726125750.5e467cfd.akpm@osdl.org>
	 <20040726203634.GA26096@elte.hu>
Content-Type: text/plain
Message-Id: <1090879146.1094.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 17:59:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 16:36, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > The bigger this thing gets, the more worried I get.  Sometime this is
> > going to need to be split up into individual fixes, and they need to
> > be based upon an overall approach which we haven't yet settled on.
> 
> i will do that splitup. Right now i'm simply mapping how widespread the
> problem is and what type of fixes we need. The situation isnt all that
> bad but we might need (an optional) mechanism to make softirqs
> synchronous. All of this stuff is nicely modular and i'll do a splitup
> post 2.6.8 (i dont think we want to disturb 2.6.8 with any of this).
> 

>From a user's perspective, and based on my own testing, I do not see the
patch having to get much bigger, the vast majority of the hot spots have
been fixed, and the patch remains quite comprehensible even to someone
with a sketchy knowledge of the kernel.  There is only one issue I can
think of that has not been addressed at all (the PS/2 Caps Lock issue). 
All that seems to remain are tweaks to individual fixes that are already
in the patch.

Lee

