Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWDJNij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDJNij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDJNij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:38:39 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:45516 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751150AbWDJNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:38:38 -0400
Date: Mon, 10 Apr 2006 15:38:31 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pchdtv 3000 cx88 audio very very low level
Message-ID: <20060410133831.GA22079@rhlx01.fht-esslingen.de>
References: <8764lmnlcx.fsf@stark.xeocode.com> <20060407092426.GA21330@rhlx01.fht-esslingen.de> <87d5ftmt5p.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5ftmt5p.fsf@stark.xeocode.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 07, 2006 at 09:06:42AM -0400, Greg Stark wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:
> 
> > IOW, you need to examine the driver sources of cx88xx, cx8800, cx88_alsa,
> > btcx_risc, tveeprom (?) for some multiplexer bit mask and tweak/twiddle that
> > for your tuner until you manage to hear something properly.
> 
> Hm. Except nobody else seems to have this problem with the pchdtv 3000 card.
> And there are plenty of HOWTOs and FAQs online for it. Perhaps nobody else is
> trying to use the NTSC tuner on it though.

A distant possibility might be that your card is a very specific rare revision
of that thing and thus doesn't have a proper card type entry for it due to
almost nobody else having that card.
In the TV card area (just as in the WLAN card area) there are quite some cards
sold under the *very same* name but wildly (or not so wildly but sufficiently)
differing hardware (those manufacturer b****rds burn in hell please, thanks).

> I'm assuming that if cx88_alsa found any audio devices on the card then it
> would create a card1 listed in /proc/asound/cards ? It isn't doing that
> currently. Apparently not all cx88 cards provide a mixer interface.

I'm not that familiar with ALSA user-space interface specifics (rather than
kernel-level), sorry.

Andreas Mohr
