Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbTCOUQT>; Sat, 15 Mar 2003 15:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCOUQT>; Sat, 15 Mar 2003 15:16:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:35109
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261542AbTCOUPp>; Sat, 15 Mar 2003 15:15:45 -0500
Date: Sat, 15 Mar 2003 15:23:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: dan carpenter <d_carpenter@sbcglobal.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, "" <wrlk@riede.org>
Subject: Re: Any hope for ide-scsi (error handling)?
In-Reply-To: <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
Message-ID: <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, dan carpenter wrote:

> > Apart from the schedule with the ide_lock held, what is that code actually
> > doing?
> >
> > 	Zwane
> 
> Hm...  Good question.  I have no idea what the while loop is for.

I suppose the magik is in the comments;

/* first null the handler for the drive and let any process
 * doing IO (on another CPU) run to (partial) completion
 * the lock prevents processing new requests */


-- 
function.linuxpower.ca
