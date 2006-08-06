Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWHFXPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHFXPN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWHFXPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:15:12 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:63403 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1750765AbWHFXPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:15:11 -0400
Date: Mon, 7 Aug 2006 01:15:06 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend on Dell D420
Message-ID: <20060806231506.GA2784@uio.no>
References: <20060804162300.GA26148@uio.no> <200608050126.57060.rjw@sisk.pl> <20060805082321.GB27129@uio.no> <200608051108.01180.rjw@sisk.pl> <20060806115043.GA30671@uio.no> <20060806231013.GD4205@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060806231013.GD4205@ucw.cz>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 11:10:13PM +0000, Pavel Machek wrote:
> Interesting... I guess getting some dump where it hangs is not an
> option? Does video work for you during resume?

Define "getting some dump". It doesn't react to anything, so I don't really
think I can easily get anything out.

When the resume works (ie. with 2.6.16, with patched 2.6.17, or with 2.6.17
without SMP), video works, but only with the -s and -p flags to s2ram (sav
VBE state and POST the video card, respectively).

> Can you try minimal drivers? It works for other people (smp too), so
> it may be driver problem (althrough it looks unlikely)

I've tried from init=/bin/bash on an initramfs (which should be about the
minimal you can get); no change in behaviour. (I've already blacklisted
sdhci, since I got a tip it might be bad and I don't really need it; if I get
this to work, I'll try whitelisting it again and see if resume works with it,
but that's a different story.)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
