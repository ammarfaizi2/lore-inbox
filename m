Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTG1M2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbTG1M2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:28:48 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:2568 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263997AbTG1M2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:28:47 -0400
Date: Mon, 28 Jul 2003 13:43:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update 0.9.6
Message-ID: <20030728134359.A2558@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jaroslav Kysela <perex@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307281421360.28950-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307281421360.28950-100000@pnote.perex-int.cz>; from perex@suse.cz on Mon, Jul 28, 2003 at 02:24:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 02:24:24PM +0200, Jaroslav Kysela wrote:
> <perex@suse.cz> (03/07/28 1.1597)
>    ALSA 0.9.6 update
>      - added __setup() to all midlevel modules
>      - sequencer protocol 1.0.1
>        - added timestamping flags for ports
>      - OSS PCM emulation
>        - fixed write() behaviour
>        - added two new options no-silence & whole-frag
>        - a try to fix OOPSes caused in the rate plugin
>      - emu10k1 driver
>        - more support for Audigy/Audigy2 EX
>        - fixed soundfont locking
>      - sb16 driver
>        - fixed fm_res handling (and proc OOPS)

Any chance you could finally submit individual changes as patches /
changesets like everyone else does?  For the new primary sound driver
ALSA has quite a bit too much CVS mentality, these monthly or whatever
updates make it really hard to track individual changes and you have
a rather bad track record of backing out changes done in mainline
in the meantime..

