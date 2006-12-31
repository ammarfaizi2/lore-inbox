Return-Path: <linux-kernel-owner+w=401wt.eu-S932737AbWLaEug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWLaEug (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 23:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWLaEuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 23:50:35 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:47415 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932737AbWLaEuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 23:50:35 -0500
Message-ID: <459741A1.9020909@lwfinger.net>
Date: Sat, 30 Dec 2006 22:50:41 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Tobin Davis <tdavis@dsl-only.net>
CC: Daniel Drake <dsd@gentoo.org>, alsa-devel@alsa-project.org,
       LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Alsa-devel] Regression in 2.6.19 and 2.6.20 for snd_hda_intel
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>	 <45972EFD.3010103@lwfinger.net>  <45973283.7060801@gentoo.org> <1167538094.9563.230.camel@localhost>
In-Reply-To: <1167538094.9563.230.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobin Davis wrote:
> Which alsa patch was this?  I'm not seeing anything in the hg logs for
> this.  Or is this something from the kernel side?

It seems to have come from suse. The full commit message is:

commit a7da6ce564a80952d9c0b210deca5a8cd3474a31
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Sep 6 14:03:14 2006 +0200

    [ALSA] hda-codec - Add independent headphone volume control

    This patch addes the support of the independent 'Headphone' volume
    control to the generic codec parser.  Some codecs (e.g. Conexant)
    have separate connections to the headphone and the independent amp
    adjustment is needed.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Jaroslav Kysela <perex@suse.cz>

:100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c

Larry


