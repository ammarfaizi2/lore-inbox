Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264286AbRFGHDb>; Thu, 7 Jun 2001 03:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264348AbRFGHDU>; Thu, 7 Jun 2001 03:03:20 -0400
Received: from kivc.vstu.vinnica.ua ([62.244.53.242]:4224 "EHLO
	kivc.vstu.vinnica.ua") by vger.kernel.org with ESMTP
	id <S264345AbRFGHDO>; Thu, 7 Jun 2001 03:03:14 -0400
Date: Thu, 7 Jun 2001 09:57:23 +0300
From: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: isolating process..
Message-ID: <20010607095723.C1706@kivc.vstu.vinnica.ua>
Mail-Followup-To: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010605123755.B5998@kivc.vstu.vinnica.ua> <20010606215725.H27260@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606215725.H27260@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Wed, Jun 06, 2001 at 09:57:25PM +0200
X-Logged: Logged by kivc.vstu.vinnica.ua as f576vN701778 at Thu Jun  7 09:57:23 2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 09:57:25PM +0200, Erik Mouw wrote:

>> Is it possible by any means to isolate any given process, so that
>> it'll be unable to crash system. 
> You just gave a nice description what an OS kernel should do :)
* Sigh * :-)

> > Please, supply ANY suggestions.
> > 
> > My ideas:
> > 
> > create some user, and decrease his ulimits up to miminum of 1 process,
> > 0 core size, appropriate memory/ etc.
> That's indeed the way to do it.
Byt how should I restrict him open socket and send some data (my IP,
for example) somewhere ??

I thinks I'll end up writing kernel module which will restrict all
ioctls but few {mmap, brk, geteuid, geuid, etc..} for given UID.


thank, thought.
