Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUG1SkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUG1SkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUG1SkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:40:20 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:59325 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S262114AbUG1SkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:40:15 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Wed, 28 Jul 2004 20:37:14 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: MatzeBraun@gmx.de, zab@redhat.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [2.6 PATCH] front buttons wouldn't mute ESS Maestro
Message-ID: <20040728183714.GE3636@bouh.is-a-geek.org>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, MatzeBraun@gmx.de,
	zab@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040724224129.GC19273@bouh.is-a-geek.org> <s5h7jso11hg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h7jso11hg.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i-nntp3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer 28 jui 2004 à 19:32:43 +0200, Takashi Iwai a tapoté sur son clavier :
> ALSA doesn't unmute automatically, so I'm afraid that we'll need a
> code for that, too.

Well, that's not necessarily a need: provided that the *mix program you
uses does unmute, there's no trouble: I tested aumix, which does fine,
and alsamixer, which indeed doesn't unmute, but has a key for this, and
it fact, in might be useful to change volume level while muted, and then
suddenly unmute.

Regards,
Samuel
