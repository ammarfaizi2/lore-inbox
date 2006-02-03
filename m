Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWBCS0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWBCS0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWBCS0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:26:03 -0500
Received: from xenotime.net ([66.160.160.81]:32694 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751340AbWBCS0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:26:01 -0500
Date: Fri, 3 Feb 2006 10:25:58 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface:
 Introduction
In-Reply-To: <43E39F2B.5080408@drzeus.cx>
Message-ID: <Pine.LNX.4.58.0602031025140.32067@shark.he.net>
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
 <43E39F2B.5080408@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Pierre Ossman wrote:

> Dan Williams wrote:
> >
> > The ADMA (Asynchronous / Application Specific DMA) interface is proposed
> > as a cross platform mechanism for supporting system CPU offload engines.
> > The goal is to provide a unified asynchronous interface to support
> > memory copies, block xor, block pattern setting, block compare, CRC
> > calculation, cryptography etc.  The ADMA interface should support a PIO
> > fallback mode allowing a given ADMA engine implementation to use the
> > system CPU for operations without a hardware accelerated backend.  In
> > other words a client coded to the ADMA interface transparently receives
> > hardware acceleration for its operations depending on the features of
> > the underlying platform.
> >
>
> I'm wondering, how common is this ADMA acronym? I've been writing a MMC
> driver for some hardware where specifications aren't available. I have
> found one document which list an "ADMA system address" register, with a
> width of 64 bits. What are the odds of this being something that
> conforms to said interface?

oh dear, i thought it was either Advanced or Accelerated DMA, fwiw.

-- 
~Randy
