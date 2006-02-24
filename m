Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWBXQQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWBXQQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWBXQQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:16:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27354 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932317AbWBXQQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:16:47 -0500
Date: Fri, 24 Feb 2006 17:16:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: es1371 sound problems
Message-ID: <20060224161631.GB1925@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1wxtdmri.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've seen similar messages in some reports but haven't figured out the
> cause yet.
> 
> To be sure, could you check the patch below, making the wait time in
> codec acceessor longer?
> Also, try to build ens1371 driver as a module.

Tried that... only msleep() hunks did apply, but that should be only
more conservative, AFAICT. It took looong time to boot (my fault,
should have used 50, not 0xa000 or how much is that), but same result
as before. I tried loading it as a module, but same problem :-(.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
