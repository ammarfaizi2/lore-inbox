Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSLMTUF>; Fri, 13 Dec 2002 14:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSLMTUE>; Fri, 13 Dec 2002 14:20:04 -0500
Received: from pcp748446pcs.manass01.va.comcast.net ([68.49.120.237]:6784 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id <S265277AbSLMTUE>; Fri, 13 Dec 2002 14:20:04 -0500
Date: Fri, 13 Dec 2002 14:27:37 -0500
To: Thomas Molina <tmolina@copper.net>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: orinoco_cs not working in 2.5.51
Message-ID: <20021213192733.GA1036@bittwiddlers.com>
References: <1039654621.1410.4.camel@lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039654621.1410.4.camel@lap>
User-Agent: Mutt/1.4i
From: "Matthew Harrell,,," <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.65 (Johnstown)
Reply-To: "Matthew Harrell,,," 
	  <mharrell-dated-1040239658.d63f06@charon.bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After building 2.5.51 I am still unable to unable to load and configure
> drivers for an eth0 wireless interface on my Presario 12XL325 laptop. The
> SMC2632W card works on all 2.4 kernels and 2.5 kernels through  2.5.47 as
> previously documented in messages to this list.  Nothing after 47 will
> load and configure the eth0 device.
> 
> Mindful of the unsettled nature of module loading in latter 2.5 versions,
> I do a build with modular components and a build with everything built in.
> Rusty Russell's latest module init tools work well with both 2.4 and 2.5
> kernels, so I'm skeptical that module loading problems are the cause of
> my problem.

Well, in my case the modules load fine and appear to be working but pump 
gets errors and cannot use dhcp to get me an address.  When I manually configure
the interface with an IP then it works fine.  No idea what the proble with
that is.

Anyway, have you run "ifconfig" and "iwconfig" on the device to check that
the settings are alright?  If they are then manually give it an IP and see
if that works.

-- 
  Matthew Harrell                          Any sufficiently advanced bug is
  Bit Twiddlers, Inc.                       indistinguishable from a feature.
  mharrell@bittwiddlers.com     
