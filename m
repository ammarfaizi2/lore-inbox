Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWC1Svw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWC1Svw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWC1Svw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:51:52 -0500
Received: from styx.suse.cz ([82.119.242.94]:46004 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750964AbWC1Svw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:51:52 -0500
Date: Tue, 28 Mar 2006 20:51:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Joseph Fannin <jfannin@gmail.com>, Stas Sergeev <stsp@aknet.ru>,
       dtor_core@ameritech.net, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-ID: <20060328185147.GA6475@suse.cz>
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru> <20060328183140.GA21446@nineveh.rivenstone.net> <Pine.LNX.4.58.0603282040480.2538@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603282040480.2538@be1.lrz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 08:43:35PM +0200, Bodo Eggert wrote:
> On Tue, 28 Mar 2006, Joseph Fannin wrote:
> 
> >     I would think the ideal situation would be to make every ALSA
> > device capable of acting as the console bell (defaulting to muted,
> > like every other ALSA mixer control).  Then only pcspkr would be the
> > odd case (though maybe a common one).
> > 
> >     I dunno if there's a reasonably easy way to do that (without
> > changing every ALSA driver) though.
> 
> I think that should be done using a userspace input device if possible.
 
It certainly is. That way configuring the exact sound it makes would
also possible. The latency might be a problem, though.

-- 
Vojtech Pavlik
Director SuSE Labs
