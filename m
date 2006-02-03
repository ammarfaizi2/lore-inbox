Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWBCSVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWBCSVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWBCSVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:21:45 -0500
Received: from [85.8.13.51] ([85.8.13.51]:27372 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751313AbWBCSVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:21:44 -0500
Message-ID: <43E39F2B.5080408@drzeus.cx>
Date: Fri, 03 Feb 2006 19:21:31 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface:
 Introduction
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
In-Reply-To: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> 
> The ADMA (Asynchronous / Application Specific DMA) interface is proposed
> as a cross platform mechanism for supporting system CPU offload engines.
> The goal is to provide a unified asynchronous interface to support
> memory copies, block xor, block pattern setting, block compare, CRC
> calculation, cryptography etc.  The ADMA interface should support a PIO
> fallback mode allowing a given ADMA engine implementation to use the
> system CPU for operations without a hardware accelerated backend.  In
> other words a client coded to the ADMA interface transparently receives
> hardware acceleration for its operations depending on the features of
> the underlying platform.
> 

I'm wondering, how common is this ADMA acronym? I've been writing a MMC
driver for some hardware where specifications aren't available. I have
found one document which list an "ADMA system address" register, with a
width of 64 bits. What are the odds of this being something that
conforms to said interface?

Rgds
Pierre

