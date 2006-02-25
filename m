Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWBYR21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWBYR21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBYR21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:28:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932366AbWBYR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:28:26 -0500
Subject: Re: [2.6 patch] make UNIX a bool
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <44009024.5050105@osdl.org>
References: <20060225160150.GX3674@stusta.de>  <44009024.5050105@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 18:28:11 +0100
Message-Id: <1140888491.2991.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 09:13 -0800, Stephen Hemminger wrote:
> Adrian Bunk wrote:
> > CONFIG_UNIX=m doesn't make much sense.
> >
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >
> >   
> Why? You can build unix domain sockets as a loadable module and
> it runs fine (or it did last I tried). Whether that makes sense from a 
> distribution point of
you didn't use to when modutils used unix sockets internally :)

unix also needs a bunch of deeply internals exported that apparently
people want to play with...

