Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbULLAjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbULLAjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 19:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbULLAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 19:39:48 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:22668
	"HELO fargo") by vger.kernel.org with SMTP id S262042AbULLAjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 19:39:46 -0500
Date: Sun, 12 Dec 2004 01:38:57 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Simos Xenitellis <simos74@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041212003857.GA14844@fargo>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Simos Xenitellis <simos74@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr> <1102803807.3183.59.camel@kl> <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan ;),

> >I am not sure how you wrote the above characters. According to UTF-8,
> >characters with codepoints above 0x79 require two bytes so that to be
> >valid. When you compose "ö" (you press something like ";", then "o") in
> >the console?
> 
> ö is a "native key" on my keyboard, i.e. i do not need to play with compose to 
> generate ö.

Aaahh ;), you've should said that before. The whole problem with the
kernel is with the compose tables. If you have a native key for "ö" in
your keyboard you'll not have problems. I can type for example a 'n
with tilde' in my keyboard because is too is a native key, but for
accentuated characters, for utf-8 output is neccesary to apply the patch :-/

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
