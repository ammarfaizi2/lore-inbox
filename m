Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUBYOdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUBYOdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:33:43 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:5391 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261345AbUBYOc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:32:59 -0500
Date: Wed, 25 Feb 2004 15:32:55 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: David Weinehall <david@southpole.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.3 - fix for undefined mdelay in 3c505
Message-ID: <20040225143254.GM16814@gruby.cs.net.pl>
References: <20040225141101.GK16814@gruby.cs.net.pl> <20040225142434.GZ17140@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225142434.GZ17140@khan.acc.umu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:24:34PM +0100, David Weinehall wrote:
> On Wed, Feb 25, 2004 at 03:11:01PM +0100, Jakub Bogusz wrote:
> > This patch fixes undefined mdelay() in 3c505 driver - at least on alpha
> > (maybe on other archs <linux/delay.h> is included by some other headers,
> > but on alpha it isn't) there was warning:
> > 
> > *** Warning: "mdelay" [drivers/net/3c505.ko] undefined!
> 
> You aren't seriously using a 3c505 on an Alpha, are you?!

No, I'm not. Just trying to compile kernel with "most-module/most-yes"
config ;)
Kconfig allows to enable this, so it should build cleanly, right?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/
