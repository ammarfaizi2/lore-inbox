Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUADLNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUADLNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:13:25 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:49341 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265377AbUADLNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:13:19 -0500
Date: Sun, 4 Jan 2004 03:12:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Lincoln Dale <ltd@cisco.com>,
       Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104111257.GO1882@matchmail.com>
Mail-Followup-To: Soeren Sonnenburg <kernel@nn7.de>,
	Nick Piggin <piggin@cyberone.com.au>, Lincoln Dale <ltd@cisco.com>,
	Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <1073211879.3261.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073211879.3261.6.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 11:24:39AM +0100, Soeren Sonnenburg wrote:
> [...]
> > Or, out of interest, an alternate scheduler?
> > 
> > http://www.kerneltrap.org/~npiggin/w29p2.gz
> > (applies 2.6.1-rc1-mm1, please renice X to -10 or so)
> 
> Thats nothing *I* can try out as I am on the powerpc benh tree.
> 

Says who?  The scheduler isn't platform specific.  Nick, do you have any per
arch defines in your patch?
