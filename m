Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUANHp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 02:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUANHp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 02:45:28 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:61071 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264300AbUANHp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 02:45:27 -0500
To: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
Cc: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>
Subject: No mouse wheel under 2.6.1 [Was: Re: Where are 2.6.x upgrade notes?]
References: <87ptdocmf1.fsf@stark.xeocode.com>
	<003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl>
In-Reply-To: <003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 14 Jan 2004 02:45:25 -0500
Message-ID: <873caj0y96.fsf_-_@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej Soltysiak" <solt@dns.toxicfilms.tv> writes:

> > Upgrade FAQ somewhere like there was with 2.4?
>
> Kind of, yes. A lengthy document, but still...
> I think the 'Known Gotchas' section could be extended by
> new problems that might appear. ALSA being muted issue
> is not included there.

Well I think ALSA being muted will catch lots of people. As luck would have it
it was the one thing I knew about in advance and it didn't help. As far as I
can tell the Alsa i810 driver just doesn't produce audio at all. I tried both
the kernel source and the 1.0.1 source. Thankfully the OSS drivers still work.

But I'm still stuck with no mouse wheel. I'm really weirded out by this. I've
tried both /dev/psaux and /dev/input/mouse0 and neither allow X to receive
anything for the mouse wheel. 

I'm using protocol MousemanPlusPS/2 with this logitech M-C48 mouse, which has
always worked fine in the past. I just verified it still works fine under
2.4.23pre4 with the same version of X.

Does it work for anyone else?

-- 
greg

