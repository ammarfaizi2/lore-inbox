Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVAMONz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVAMONz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVAMONz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:13:55 -0500
Received: from news.suse.de ([195.135.220.2]:44167 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261629AbVAMONy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:13:54 -0500
Message-ID: <41E68215.8060004@suse.de>
Date: Thu, 13 Jan 2005 15:13:41 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8a6) Gecko/20041202
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com, DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org> <41E42691.3060102@softplc.com> <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org> <41E44248.2000500@softplc.com> <Pine.LNX.4.58.0501111322060.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501111322060.2373@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> What I don't see is why the port changes state, then. Since the yenta 
> driver doesn't care for the interrupt anyway, it shouldn't be touching the 
> hardware, and if it doesn't touch the hardware, then the pcmcia thing 
> should eventually just calm down, even if it were to de-bounce a few 
> times.
> 
> The above is what you'd likely see if somebody was forcing a reset on the
> card or a card voltage re-interrogation all the time, which I don't see
> why it would happen.

i have a "feeling" that a weak power supply or a little bit too high 
current draw from the card may cause something like this. But this is 
just what i wrote: a feeling from my stomach ;-)

Stefan
