Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTHLPMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTHLPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:11:45 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:46093
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S270444AbTHLPLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:11:24 -0400
Date: Tue, 12 Aug 2003 17:11:19 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
Message-ID: <20030812151119.GA1639@man.beta.es>
References: <20030811102236.GA731@man.beta.es> <s5hwudji5xf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwudji5xf.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The ALSA problem is new, ALSA for 2.4 (0.9.4) is working perfectly, but the
> > 2.6.0 driver doesn't allow me to hear the beeper sound, the pcm sounds seem
> perhaps CONFIG_INPUT_PCSPKR is set off?

Yes, sorry about this one, I didn't knew this option, which is also quite
hidden under INPUT_MISC, and also I thought the beeper was an output device,
not input :-??? Anyway, it was that and after activating it, it works ok.

Thanks!
-- 
Manty/BestiaTester -> http://manty.net
