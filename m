Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbSLEV4S>; Thu, 5 Dec 2002 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSLEV4S>; Thu, 5 Dec 2002 16:56:18 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:51378
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S267485AbSLEV4Q>; Thu, 5 Dec 2002 16:56:16 -0500
Date: Thu, 5 Dec 2002 14:03:49 -0800
From: Phil Oester <kernel@theoesters.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>,
       "'ja@ssi.bg'" <ja@ssi.bg>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
Message-ID: <20021205140349.A5998@ns1.theoesters.com>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039124530.18881.0.camel@rth.ninka.net>; from davem@redhat.com on Thu, Dec 05, 2002 at 01:42:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So we should enable netfilter for all x-hundred webservers we have?  Or play games with routing tables?

Why was something which:

a) works
b) was present in 2.2.xx kernels
c) is trivial to include and doesn't seem to 'hurt' anything

ripped from 2.4 kernels?

What some people fail to grasp is that _many_ people in the real world are using the hidden flag in load balancing scenarios for its simplicity.  Removing it (without any particularly valid reason that anyone is aware of) doesn't make much sense.

-Phil

p.s. flame away, Dave

On Thu, Dec 05, 2002 at 01:42:10PM -0800, David S. Miller wrote:
> On Thu, 2002-12-05 at 12:53, Bingner Sam J Contractor PACAF CSS/SCHE
> wrote:
> > Attached is a patch that seems to work for the hidden flag in 2.4.20... for
> > anybody else who needs this functionality
> 
> Use the ARP filter netfilter module or the routing based solutions
> instead, please.
