Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUAVP74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAVP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:59:56 -0500
Received: from ppp-82-135-4-160.mnet-online.de ([82.135.4.160]:16000 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264583AbUAVP7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:59:54 -0500
Date: Thu, 22 Jan 2004 16:57:32 +0100
From: Julien Oster <frodoid@frodoid.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: parhelia doesn't work anymore with 2.6.1
Message-ID: <20040122155732.GB1138@frodo.midearth.frodoid.org>
References: <20040122152137.GA1138@frodo.midearth.frodoid.org> <20040122155016.GA18361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122155016.GA18361@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:50:16PM +0000, Dave Jones wrote:

Hello Dave,

>  > I know the Matrox Parhelia kernel driver ist partly a binary only
>  > driver, but I am not explicitly asking for support on that driver.

> actually, you are. agpgart works fine with free drivers.

Yeah, but actually, I'm pretty desperate :)

>  > My question is: what has changed in AGP code or similar between 2.4.24
>  > and 2.6.1 that can make my Parhelia unusable?

> 'lots'. seriously, they're worlds apart. they're not the same driver any more.
> in fact in 2.6, agpgart is multiple drivers.

That last bit I know. And with agpgart and nvidia-agp loaded, it's
actually using AGP... but the screen is a real mess.

> Trying to use a 2.4 module on 2.6 is going to cause you pain. lots of pain.

And you can not by chance point me to some locations where I can figure
out myself, so that I could try to patch the opensource portion myself?
It really looks like all relevant code would be in the opensource
portion.

Judging from my point of view I think it must have something to do with
different memory mapping or the like, as it looks like my X server
(independent mode, so I should actually have two framebuffers) is
writing into the same (physical?) memory area for both screens.

Just give me some hints where I should start browsing the code, I can
figure out thinks myself then. Pretty, pretty please :-)

Regards,
Julien
