Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSHZH07>; Mon, 26 Aug 2002 03:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSHZH07>; Mon, 26 Aug 2002 03:26:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22463 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317971AbSHZH05>;
	Mon, 26 Aug 2002 03:26:57 -0400
Date: Mon, 26 Aug 2002 09:30:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: erik@debill.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
Message-ID: <20020826093050.A2524@ucw.cz>
References: <20020825215515.GA2965@debill.org> <Pine.LNX.4.44.0208251601060.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208251601060.3234-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Sun, Aug 25, 2002 at 04:02:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 04:02:07PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sun, 25 Aug 2002 erik@debill.org wrote:
> > Would this explain my computer losing 2-3 minutes of time while
> > ripping a cd?  Normally it's dead on (w/ ntpd running to guarantee
> > that) but while ripping or burning it loses so badly ntpd can't keep
> > up.
> 
> We call it 'heavy interrupt load'. The more errors can happen, the more 
> errors do happen. (And by the way, I've already seen VIA chipsets jump off 
> by hours.)

It's always the same amount - about four hours - there is an underflow to
negative values with unsigned ints.

-- 
Vojtech Pavlik
SuSE Labs
