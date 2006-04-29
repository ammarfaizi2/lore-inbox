Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWD2KgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWD2KgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWD2KgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:36:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43964 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbWD2KgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:36:04 -0400
Subject: Re: IP1000 gigabit nic driver
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       David Vrabel <dvrabel@cantab.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <1146306567.1642.3.camel@localhost>
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	 <20060428113755.GA7419@fargo>
	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	 <1146306567.1642.3.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Apr 2006 12:35:36 +0200
Message-Id: <1146306936.3125.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-29 at 13:29 +0300, Pekka Enberg wrote:
> On Fri, 28 Apr 2006, David Gómezz wrote:
> > > Ok, i could take care of that, and it's a good way of getting my hands
> > > dirty with kernel programming ;). David, if it's ok to you i'll do the
> > > cleanup thing.
> 
> On Fri, 2006-04-28 at 14:59 +0300, Pekka J Enberg wrote:
> > Here are some suggestions for coding style cleanups:
> 
> [snip]
> 
> I ended up doing most of them myself [1]. Sorry :-) Are the datasheets
> public by the way?


you want to nuke the ioctl btw and just use ethtool ioctl instead

