Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSHLHH4>; Mon, 12 Aug 2002 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSHLHHz>; Mon, 12 Aug 2002 03:07:55 -0400
Received: from shill.XCF.Berkeley.EDU ([128.32.112.247]:34574 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id <S317421AbSHLHHz>;
	Mon, 12 Aug 2002 03:07:55 -0400
Date: Mon, 12 Aug 2002 00:11:41 -0700
From: Joshua Uziel <uzi@uzix.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kieran@esperi.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Ultrasparc 1 network freeze
Message-ID: <20020812071140.GB925@uzix.org>
References: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix> <20020811223010.GB16890@uzix.org> <20020811.182923.02248401.davem@redhat.com> <20020812050928.GA925@uzix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020812050928.GA925@uzix.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joshua Uziel <uzi@uzix.org> [020811 22:14]:
> * David S. Miller <davem@redhat.com> [020811 18:44]:
> > Hmmm, can the people who can reproduce this try this patch instead?
> 
> Yeah Dave, that seems to do it... at least with my testing on a U1/170E.
> Previously, simply ping flooding it from another box would cause the
> lockup pretty quickly.

Damn, scratch that, dude... it definitely helps, but I just had it
happen to me with your patch.  It's much harder to reproduce with your
patch...
