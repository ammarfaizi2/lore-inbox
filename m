Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUCKUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUCKUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:03:59 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:49332 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S261681AbUCKUD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:03:56 -0500
X-BrightmailFiltered: true
Date: Thu, 11 Mar 2004 21:04:06 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Damian Kolkowski <damian@kolkowski.no-ip.org>
Subject: Re: [i386] 2.6.4 + cdrtools-2.01a27 REPORT
Message-ID: <20040311200406.GA12780@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040311162303.ALLYOURBASEAREBELONGTOUS.B29383@kolkowski.no-ip.org> <20040311175109.GA2467@dreamland.darkstar.lan> <20040311194714.ALLYOURBASEAREBELONGTOUS.B25581@kolkowski.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311194714.ALLYOURBASEAREBELONGTOUS.B25581@kolkowski.no-ip.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Mar 11, 2004 at 08:47:14PM +0100, Damian Kolkowski ha scritto: 
> * Kronos <kronos@kronoz.cjb.net> [2004-03-11 18:53]:
> > Which driver are you using? This card should be supported by the new
> > driver (and afaics also from the old one). If the new driver doesn't
> > work for you can you send me a "lspci -nvvv" of your board?
> 
> Yep it's should but now in new version it's evil code :-)
> 
> Two drivers old and new one just won't listen to append i lilo.conf, even
> fbset on old radeonfb mess with consle, demolish resolution to some unsuported
> value.
> New one is better, just use fbset -a -fb /dev/fb0 -depth 32 1024x768-100 and
> you have one small screan i upper left corner off your screan ;-)
> Bigger resolutions makes it smeller.

You need to use stty to adjust the number of rows and cols. Pay
attention to values you use, otherwise your machine will die due to
massive memory corruption...

Luca
-- 
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
