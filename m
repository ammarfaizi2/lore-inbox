Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGISWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGISWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGISWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:22:34 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:55132 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261667AbVGISWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:22:33 -0400
Subject: Re: linux-2.6.12-RT-V0.7.51-18: RT task yield()-ing!
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1120932877.6488.61.camel@mindpipe>
References: <1120919366.14404.5.camel@twins>
	 <1120932877.6488.61.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 20:22:31 +0200
Message-Id: <1120933352.14404.18.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 14:14 -0400, Lee Revell wrote:
> On Sat, 2005-07-09 at 16:29 +0200, Peter Zijlstra wrote:
> >  [<f09ce1a4>] emu10k1_audio_release+0x114/0x210 [emu10k1] (40)
> 
> Kind of OT, but any particular reason you're using this old OSS driver?
> It's likely to be deprecated soon, and the ALSA driver is much more
> actively maintained...

yeah, my sblive is a bit busted; my front line-out jack is broken and
only gives 1 channel, hence I use the back line-out. The alsa driver has
some fancy channel routing stuff in there that doesn't work out of the
box for me.

I once made a patch so that the front and back channels were inverted
but I lost it somewhere. And since I'm a lazy ass I kept using the OSS
driver. It's not as if I actually use my sblive for anything else but
the occasional mp3. But I guess I have to go and figure that channel
routing stuff out once again.

Regards,

PeterZ




