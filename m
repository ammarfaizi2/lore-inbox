Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUATOZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbUATOZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:25:20 -0500
Received: from ns.suse.de ([195.135.220.2]:18657 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265576AbUATOZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:25:14 -0500
Date: Tue, 20 Jan 2004 15:24:22 +0100
From: Olaf Dabrunz <od@suse.de>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA vs. OSS
Message-ID: <20040120142422.GA14811@suse.de>
References: <1074532714.16759.4.camel@midux> <Pine.LNX.4.58.0401192036070.3707@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401192036070.3707@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-Jan-04, Jaroslav Kysela wrote:
> > So, what are the reasons for ALSA to become "default" in 2.6?
> > I know it gives somekind of nice features, but ALSA didn't let me to
> > open two sound sources (like XMMS and Quake3) at the same time, so I
> > guess it is not really done yet, or is it?
> 
> We don't do this in kernel. We implemented the direct stream mixing in our 
> library (userspace). If your applications already uses ALSA APIs or if you 
> redirect the OSS ioctls to ALSA library (our aoss library), you can enjoy 
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How can this be done? Just by creating symlinks?

> multiple sounds.
> 
> Of course, using hardware which can do the hardware mixing is still 
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Oh, so ALSA does not use the hardware mixing capabilities of the
emu10k-chips?

Will this be possible sometime?

> better. It's the same difference like between sw 3D rendering and hw 3D 
> rendering.
> 
> 						Jaroslav

-- 
Olaf Dabrunz (od / odabrunz), SUSE Linux AG, Nürnberg

