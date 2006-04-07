Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWDGNGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDGNGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDGNGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:06:51 -0400
Received: from stark.xeocode.com ([216.58.44.227]:22758 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S1751273AbWDGNGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:06:50 -0400
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pchdtv 3000 cx88 audio very very low level
References: <8764lmnlcx.fsf@stark.xeocode.com>
	<20060407092426.GA21330@rhlx01.fht-esslingen.de>
In-Reply-To: <20060407092426.GA21330@rhlx01.fht-esslingen.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 07 Apr 2006 09:06:42 -0400
Message-ID: <87d5ftmt5p.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

> IOW, you need to examine the driver sources of cx88xx, cx8800, cx88_alsa,
> btcx_risc, tveeprom (?) for some multiplexer bit mask and tweak/twiddle that
> for your tuner until you manage to hear something properly.

Hm. Except nobody else seems to have this problem with the pchdtv 3000 card.
And there are plenty of HOWTOs and FAQs online for it. Perhaps nobody else is
trying to use the NTSC tuner on it though.

I'm assuming that if cx88_alsa found any audio devices on the card then it
would create a card1 listed in /proc/asound/cards ? It isn't doing that
currently. Apparently not all cx88 cards provide a mixer interface.


-- 
greg

