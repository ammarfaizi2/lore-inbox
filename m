Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSHLFFo>; Mon, 12 Aug 2002 01:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSHLFFo>; Mon, 12 Aug 2002 01:05:44 -0400
Received: from shill.XCF.Berkeley.EDU ([128.32.112.247]:65035 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id <S318715AbSHLFFo>;
	Mon, 12 Aug 2002 01:05:44 -0400
Date: Sun, 11 Aug 2002 22:09:28 -0700
From: Joshua Uziel <uzi@uzix.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kieran@esperi.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Ultrasparc 1 network freeze
Message-ID: <20020812050928.GA925@uzix.org>
References: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix> <20020811223010.GB16890@uzix.org> <20020811.182923.02248401.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811.182923.02248401.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller <davem@redhat.com> [020811 18:44]:
> Hmmm, can the people who can reproduce this try this patch instead?

Yeah Dave, that seems to do it... at least with my testing on a U1/170E.
Previously, simply ping flooding it from another box would cause the
lockup pretty quickly.

I'll try to get some more people to test it as well...
