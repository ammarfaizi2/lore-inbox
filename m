Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUBYOYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUBYOYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:24:40 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:23540 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261336AbUBYOYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:24:39 -0500
Date: Wed, 25 Feb 2004 15:24:34 +0100
From: David Weinehall <david@southpole.se>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.3 - fix for undefined mdelay in 3c505
Message-ID: <20040225142434.GZ17140@khan.acc.umu.se>
Mail-Followup-To: Jakub Bogusz <qboosh@pld-linux.org>,
	linux-kernel@vger.kernel.org
References: <20040225141101.GK16814@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225141101.GK16814@gruby.cs.net.pl>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:11:01PM +0100, Jakub Bogusz wrote:
> This patch fixes undefined mdelay() in 3c505 driver - at least on alpha
> (maybe on other archs <linux/delay.h> is included by some other headers,
> but on alpha it isn't) there was warning:
> 
> *** Warning: "mdelay" [drivers/net/3c505.ko] undefined!

You aren't seriously using a 3c505 on an Alpha, are you?!


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
