Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVAEVrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVAEVrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVAEVq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:46:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63699 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262610AbVAEVne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:43:34 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark_H_Johnson@raytheon.com, bunk@stusta.de,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       perex@suse.cz
In-Reply-To: <20050105132711.70f74ecc.akpm@osdl.org>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	 <s5his6cm1re.wl@alsa2.suse.de>  <20050105132711.70f74ecc.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 16:43:30 -0500
Message-Id: <1104961410.12817.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 13:27 -0800, Andrew Morton wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The default blocking behavior of OSS devices was changed recently.
> >  When the device is in use, open returns -EBUSY immediately in the
> >  latest version while it was blocked until released in the former
> >  version.
> > 
> 
> whoa.  That's a significant change in user-visible behaviour.  Why was this
> done?

http://sourceforge.net/mailarchive/message.php?msg_id=10011826

Lee

