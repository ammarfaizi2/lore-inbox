Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTG1NDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTG1NDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:03:35 -0400
Received: from gate.perex.cz ([194.212.165.105]:17678 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S269514AbTG1NDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:03:33 -0400
Date: Mon, 28 Jul 2003 15:17:24 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update 0.9.6
In-Reply-To: <20030728134359.A2558@infradead.org>
Message-ID: <Pine.LNX.4.44.0307281451220.28950-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Christoph Hellwig wrote:

> On Mon, Jul 28, 2003 at 02:24:24PM +0200, Jaroslav Kysela wrote:
> > <perex@suse.cz> (03/07/28 1.1597)
> >    ALSA 0.9.6 update
> >      - added __setup() to all midlevel modules
> >      - sequencer protocol 1.0.1
> >        - added timestamping flags for ports
> >      - OSS PCM emulation
> >        - fixed write() behaviour
> >        - added two new options no-silence & whole-frag
> >        - a try to fix OOPSes caused in the rate plugin
> >      - emu10k1 driver
> >        - more support for Audigy/Audigy2 EX
> >        - fixed soundfont locking
> >      - sb16 driver
> >        - fixed fm_res handling (and proc OOPS)
> 
> Any chance you could finally submit individual changes as patches /
> changesets like everyone else does?  For the new primary sound driver
> ALSA has quite a bit too much CVS mentality, these monthly or whatever
> updates make it really hard to track individual changes and you have
> a rather bad track record of backing out changes done in mainline
> in the meantime..

Although I understand your complains, you have still a chance to compare 
both sources - our ALSA CVS tree and linux BK tree to find the full 
code history.

But the changesets are really great, so I am thinking to switch the ALSA 
repository from CVS to BK soon. It will help to propagate changes better.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



