Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWAHCDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWAHCDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWAHCDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 21:03:45 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4104 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161135AbWAHCDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 21:03:44 -0500
Date: Sun, 8 Jan 2006 03:03:35 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060108020335.GA26114@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Takashi Iwai <tiwai@suse.de>,
	ALSA development <alsa-devel@alsa-project.org>,
	linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xtshzwk.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:32:27PM +0100, Takashi Iwai wrote:
> Yes, it's a known problem to be fixed.  But, it's no excuse to do
> _everything_ in the kernel (which OSS requires).

OSS does not require to do anything in the kernel except an entry
point.


> And if the application doesn't support, who and where converts it?
> With OSS API, it's a job of the kernel.

Once again no.  Nothing prevents the kernel to forward the data to
userland daemons depending on a userspace-uploaded configuration.

  OG.
