Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTHLPOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTHLPOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:14:33 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:20998
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S270438AbTHLPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:14:26 -0400
Date: Tue, 12 Aug 2003 10:14:21 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030812151421.GB1074@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812134221.GA6412@furrr.two14.net> <Pine.LNX.4.44.0308121109530.5995-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308121109530.5995-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:10:51AM -0300, Marcelo Tosatti wrote:
> I'll try to reproduce around here. In the meantime can you try to isolate 
> the corruption. You said it didnt happen with 2.4.21 -- which pre shows up 
> the problem? 

Yes, that's on my list.  Unfortunately this has so far only been seen
on my workstation, and I have to get a bit of work done before I can
pursue this.  At least I can get some candidates built in the
background.

I have tried a few things quickly with 22-rc2, and the short summary
is:

 * noapic makes no difference (don't recall why I had UP APIC enabled)

 * disabling DMA w/hdparm stops the corruption (all normal operation
   and previous testing has been with DMA enabled)

 * mounting w/ -o sync makes no difference except to slow things down

-- 
Show me your flowcharts and conceal your tables, and I shall continue
to be mystified.  Show me your tables, and I won't usually need your
flowcharts; they'll be obvious.  -- Brooks

