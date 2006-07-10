Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWGJX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWGJX7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbWGJX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:59:39 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:17161 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965335AbWGJX7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:59:39 -0400
Date: Tue, 11 Jul 2006 01:59:35 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Adam Tla?ka <atlka@pg.gda.pl>
Cc: Lee Revell <rlrevell@joe-job.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-ID: <20060710235934.GC26528@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Adam Tla?ka <atlka@pg.gda.pl>, Lee Revell <rlrevell@joe-job.com>,
	ak@suse.de, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, perex@suse.cz,
	alan@lxorguk.ukuu.org.uk
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl> <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B2E4FF.9000502@pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 01:38:39AM +0200, Adam Tla?ka wrote:
> Sorry but is a Windows solution the best on the whole world?

ALSA, with its "the API is a DLL", is a Windows solution.


> >esd and artsd are no longer needed since ALSA began to enable software
> >mixing by default in release 1.0.9.
> 
> So why they are still exist in so many Linux distributions?

That's an extremely recent change in distribution-time.


> Format changing, resampling, mixing and supporting additional plugins
> does not seems to be just low level HAL for hw device. It creates some 
> kind of virtual functionality which means more then this provided by 
> hardware device itself.

ALSA lib has something like 7 different methods just to play a sound.
Their view of "low level" is quite interesting.  Using it is pure
hell.  Debugging what you've done is worse.  And don't bother to hope
that your code will still work in six months.

  OG.

