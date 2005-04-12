Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVDLW0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVDLW0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDLWSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:18:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:9638 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262435AbVDLWR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:17:58 -0400
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.58.0504121147390.4501@ppc970.osdl.org>
References: <1113282436.21548.42.camel@gaston>
	 <1113330533.31159.43.camel@mindpipe>
	 <Pine.LNX.4.58.0504121147390.4501@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 08:16:18 +1000
Message-Id: <1113344178.5388.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 11:49 -0700, Linus Torvalds wrote:
> 
> On Tue, 12 Apr 2005, Lee Revell wrote:
> > 
> > Um... why in the heck are you posting this here instead of alsa-devel?
> 
> Which list do you think has more people interested? ppc64 or alsa?
> 
> Pretty much anybody with a G5 will probably be on the ppc lists. And 
> _nobody_ will be on the alsa lists, since it historically has never had 
> any sound at all.
> 
> In other words, don't believe that "sound" means that it must be an alsa 
> list. Lists make sense not because of intent, but because of who they 
> reach.

Yah, that, and i intend to take over this driver, and this is really
only platform specific munging in the driver itself, I pretty much don't
change anything to the way the driver interfaces to Alsa.

Once I am done rewriting it completely (which I started doing but it
will take some time to complete) to get digital, AC3, etc... I will
submit the new one to alsa-devel though for comments.

Ben.


