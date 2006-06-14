Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWFNLIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWFNLIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 07:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFNLIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 07:08:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6568 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932335AbWFNLIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 07:08:04 -0400
Date: Wed, 14 Jun 2006 13:07:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC card RS-232 freezes the computer
Message-ID: <20060614110715.GF28536@elf.ucw.cz>
References: <20060612130841.GA16993@kestrel.barix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612130841.GA16993@kestrel.barix.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 12-06-06 15:08:41, Karel Kulhavy wrote:
> Hello
> 
> When I insert "2 port RS-232" PC card/PCMCIA/carbus/whatever card
> (86x53x6mm with a golden strip with 8 nipples and 2x34 connector) into my
> Dell Inspiron 510m notebook with 2.6.16.19, the computer freezes and
> continues working when I remove it.
> 
> The card label says "2 port RS-232 SUNIX Plug Into A Brand-new World
> S/N: CB 0077996 Made in Taiwan"
> 
> XMMS before freezing plays last 300ms 3 times again.
> 
> dmesg shows
> pccard: CardBus card inserted into slot 0
> pccard: card ejected from slot 0
> MCE: The hardware reports a non fatal, correctable incident occurred on
> CPU 0.
> Bank 0: b200004000000800
> 
> Is the kernel intended to behave this way? If yes, is there a way how
> to configure up the kernel so the computer doesn't freeze and the card
> can be examined with lspci?

MCE means hardware problem. Perhaps kernel could do something to
prevent it, but...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
