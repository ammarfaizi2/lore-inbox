Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUHDHQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUHDHQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUHDHQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:16:54 -0400
Received: from styx.suse.cz ([82.119.242.94]:8320 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267295AbUHDHQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:16:52 -0400
Date: Wed, 4 Aug 2004 09:18:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Marko Macek <Marko.Macek@gmx.net>,
       Jesper Juhl <juhl-lkml@dif.dk>, Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
Message-ID: <20040804071842.GA705@ucw.cz>
References: <410FAE9B.5010909@gmx.net> <Pine.LNX.4.60.0408032257250.2821@dragon.hygekrogen.localhost> <4110660D.5050003@gmx.net> <200408040025.20118.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408040025.20118.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 12:25:19AM -0500, Dmitry Torokhov wrote:

> On Tuesday 03 August 2004 11:29 pm, Marko Macek wrote:
> > Jesper Juhl wrote:
> > 
> > > <>I also had problems with my KVM switch and mouse when I initially 
> > > moved to
> > > 2.6, but adding this kernel boot parameter fixed it, meybe it will help
> > > you as well : psmouse.proto=imps
> > 
> > This doesn't help. Only the patch I sent helps me. The problem is that the
> > even with psmouse.proto=imps or exps, the driver still probes for 
> > synaptics which I
> > consider a bug.
> > 
> 
> No it is not - Synaptics with a track-point on a passthrough port will have
> track-point disabled if it is not reset after probing for imps/exps.
 
Hmm, does the imps/exps probe succeed in this case?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
