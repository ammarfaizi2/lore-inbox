Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTL2XEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbTL2XEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:04:24 -0500
Received: from viefep14-int.chello.at ([213.46.255.13]:15714 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S265112AbTL2XEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:04:22 -0500
From: Andreas Theofilu <noreply@TheosSoft.net>
Subject: Re: 2.6.0 with frame buffer problems?
To: linux-kernel@vger.kernel.org
Newsgroups: linux.kernel
Date: Tue, 30 Dec 2003 00:04:18 +0100
References: <181SV-7V5-1@gated-at.bofh.it> <188KU-2z8-29@gated-at.bofh.it>
Organization: Theos Soft
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
Message-Id: <20031229230420.A488924002@chello062178157104.9.14.vie.surfer.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<veröffentlicht & per Mail versendet>

Gene Heskett wrote:

> # Graphics support
> #
> CONFIG_FB=y
[...]
> 
> Way too many frame buffers enabled.  Pick the one that works with your
> card and disable the vesa.  You may have to say y to the usual fonts
> too.
> 
Thanks for that hint. I did it and it's a lot better now, but unfortunately
not completely gone. Particularly the text modus is working perfect now and
I got the penguin back while booting :-).
I will spend more time to this problem, because I'm not so sure that it
belongs only to the kernel, even if someone at XFree told this.

This is what I've configured currently:
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

-- 
Andreas Theofilu
http://www.TheosSoft.net
E-Mail: andreas at TheosSoft dot net
