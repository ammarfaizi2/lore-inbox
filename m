Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270390AbUJTTZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270390AbUJTTZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269250AbUJTTT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:19:59 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:996 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270123AbUJTTS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:18:29 -0400
Date: Wed, 20 Oct 2004 12:18:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH (updated)] Avoid annoying build warning on 32-bit platforms
Message-ID: <20041020191818.GB11755@taniwha.stupidest.org>
References: <200410200956.i9K9ujOu026178@harpo.it.uu.se> <20041020102343.GA6901@taniwha.stupidest.org> <20041020125353.6af0aad6@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020125353.6af0aad6@phoebee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 12:53:53PM +0200, Martin Zwickel wrote:

> > +	if (time)
> > +		num ^= (u32)((time >> 32) >> 1);
>                                       ^^ errr ... should be 31 ?!?!

yeah, i'm retarded, sorry about that :)
