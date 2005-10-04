Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbVJDAyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVJDAyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 20:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJDAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 20:54:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27594 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751171AbVJDAyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 20:54:46 -0400
Date: Mon, 3 Oct 2005 20:54:01 -0400
From: Dave Jones <davej@redhat.com>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Message-ID: <20051004005401.GC10697@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Peter Zubaj <pzad@pobox.sk>, alsa-devel@alsa-project.org,
	James@superbug.co.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	perex@suse.cz
References: <7a5967f2d895440aa1ca2fa1d201c380@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5967f2d895440aa1ca2fa1d201c380@pobox.sk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:23:28AM +0200, Peter Zubaj wrote:
 > AFAIK this was fixed in CVS. Two cards have same model id (one has AC97, one not).
 > 
 > Fix:
 > 
 > http://sourceforge.net/mailarchive/forum.php?thread_id=8360485&forum_id=33141
 > 

>From the look of that patch, this will just print
"emu10k1: AC97 is optional on this board Proceeding without ac97 mixers..."
and do nothing about actually making things work for people again,
or even to suggest what they can do to work around this situation
when their volume control breaks.  At the least this sounds like it
needs to mention a module parameter to force ac97 support.

What actually happens if we set ac97_chip=1 on the boards that
don't have it ? Is it purely a cosmetic thing, showing some
sliders that do nothing?

		Dave

