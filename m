Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTA1KD1>; Tue, 28 Jan 2003 05:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTA1KD1>; Tue, 28 Jan 2003 05:03:27 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:38800 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264962AbTA1KD0>;
	Tue, 28 Jan 2003 05:03:26 -0500
Date: Tue, 28 Jan 2003 11:12:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, vojtech@suse.cz,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Message-ID: <20030128111203.D27323@ucw.cz>
References: <200301272057.VAA13114@harpo.it.uu.se> <1043718980.1548.3.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043718980.1548.3.camel@iso-2146-l1.zeusinc.com>; from ttsig@tuxyturvy.com on Mon, Jan 27, 2003 at 08:56:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 08:56:07PM -0500, Tom Sightler wrote:

> On Mon, 2003-01-27 at 15:57, Mikael Pettersson wrote:
> > However, your version of atkbd.c caused a linkage error due to a
> > reference to input_regs() in atkbd_interrupt(). I extracted
> > just the changes to atkbd_cleanup() and atkbd_command(), but that
> > left me with a dead keyboard on the first test box. In the end
> > I kept only the atkbd_cleanup() change and the increased timeout
> > for RESET_BAT in atkbd_command() [see below].
> 
> Just as another point of reference, I tested your patch with only the
> RESET_BAT changes and it worked on my machine as well.

Great.

-- 
Vojtech Pavlik
SuSE Labs
