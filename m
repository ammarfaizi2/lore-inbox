Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbQJZWzh>; Thu, 26 Oct 2000 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130074AbQJZWz2>; Thu, 26 Oct 2000 18:55:28 -0400
Received: from styx.suse.cz ([195.70.145.226]:58350 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130024AbQJZWzN>;
	Thu, 26 Oct 2000 18:55:13 -0400
Date: Fri, 27 Oct 2000 00:55:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Levon <moz@compsoc.man.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        faith@valinux.com, jhartmann@precisioninsight.com
Subject: Re: [PATCH] Make agpsupport work with modversions
Message-ID: <20001027005500.A11447@suse.cz>
In-Reply-To: <20001019102722.B9057@suse.cz> <200010262221.e9QMLfC32276@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010262221.e9QMLfC32276@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Oct 26, 2000 at 06:21:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 06:21:41PM -0400, Alan Cox wrote:

> > Well, this is usually handled by a third module that takes care of
> > registering/unregistering the existence of the two modules that need to
> > be possible to load/unload separately.
> 
> But that module then depends on both of the others unless you keep recompiling
> it

Not really, see for example ns558.c and adi.c plus their third module
gameport.c, all in drivers/char/joystick.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
