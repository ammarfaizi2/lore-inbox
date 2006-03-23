Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWCWMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWCWMAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWCWMAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:00:22 -0500
Received: from rune.pobox.com ([208.210.124.79]:38561 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1030235AbWCWMAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:00:22 -0500
Date: Thu, 23 Mar 2006 06:00:18 -0600
From: Rodney Gordon II <meff@pobox.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.16-ck1
Message-ID: <20060323120018.GA10050@spherenet.spherevision.org>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux list <linux-kernel@vger.kernel.org>
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org> <cone.1143114017.303805.31285.501@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1143114017.303805.31285.501@kolivas.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 10:40:17PM +1100, Con Kolivas wrote:
> Rodney Gordon II writes:
> 
> >Good job Con, on your patches.. As far as the kernel in general, I'd
> >like to post some warnings:
> 
> Thanks.
> 
> >Adaptive readahead: I had probs with this before, and I still do.. On
> >a desktop if you have odd problems (nothing responding for SECONDS,
> >very slow disk I/O during heavy I/O, etc..) disable it.
> 
> I was concerned about that myself which is why the only reason I included 
> it was because it came in a configurable form where you could choose to 
> enable it, and the default was off, and the config option even said 
> suitable to _servers_, not desktops.

Yea, just thought I would try it again sighting the improvements in
the ? docs in menuconfig, was just disappointed again.

> >The new Yukon2 "sky2" driver: This one really pissed me off. It had me
> >thinking apache2 AND my linksys router we're on the brink. For some
> >unknown reason at least for me, in FF it would only half-load some
> >pages, including ones on localhost AND my router (10.1.1.1) ... I
> >dunno what the hell is up with this one. I have to stay with the
> >syskonnect.com sk98lin patch, which.. doesn't work with 2.6.16 so I am
> >back to 2.6.15 at the moment.
> >
> >nVidia drivers: Broken. I posted a ftbfs bug on the debian bts, here
> >is a current patch that works against the current release:
> >http://bugs.debian.org/cgi-bin/bugreport.cgi/nvidia-kernel-source_1.0.8178-2.diff?bug=357992;msg=15;att=1
> 
> Luckily none of these are my fault.

Yep, just warnings in general.

> >All in all, my experience sucked for the first time on this kernel.
> 
> /me does the "not my fault" look. 

LOL, I know, just warnings in general like I have said.

> >Good luck with this new one..
> 
> Heh. No new one in the works just yet, but I'm actually not planning on 
> changing anything. Turn adaptive readahead off, and you're left with out of 
> kernel tree, or worse, binary driver problems. 

Turned it off, disk probs are gone.

Meant to say "Good luck with this new mainline one.."

Your patches are great.. Thus, why I started this post with "Good
job Con, on your patches.." ;)

-r


-- 
Rodney "meff" Gordon II               -*-              meff@pobox.com
Systems Administrator / Coder Geek    -*-       Open yourself to OpenSource
