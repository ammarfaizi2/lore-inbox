Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSKPB5g>; Fri, 15 Nov 2002 20:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSKPB5g>; Fri, 15 Nov 2002 20:57:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267200AbSKPB5f>;
	Fri, 15 Nov 2002 20:57:35 -0500
Date: Fri, 15 Nov 2002 18:03:46 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Arun Sharma <arun.sharma@intel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Reserving "special" port numbers in the kernel ?
In-Reply-To: <u65uyb82a.fsf@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.33L2.0211151802520.6746-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2002, Arun Sharma wrote:

| rddunlap@osdl.org ("Randy.Dunlap") writes:
|
| > Look in arch/i386/kernel/setup.c (in 2.4.19):
| >
| > There is this array:
| >   struct resource standard_io_resources[] = ...
| > that you could add to; you could even make the addition a CONFIG_ option.
|
| That's reserving I/O ports. Are you suggesting that we create an
| analogous array for IP ports ?

Nope.  Sorry, I read too much into "port".  :(
or maybe too much port.

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

