Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266743AbUFRTte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266743AbUFRTte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUFRTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:48:52 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:55728 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266552AbUFRTpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:45:44 -0400
Date: Fri, 18 Jun 2004 20:44:38 +0100
From: Ian Molton <spyro@f2s.com>
To: David Brownell <david-b@pacbell.net>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040618204438.35278560.spyro@f2s.com>
In-Reply-To: <40D34078.5060909@pacbell.net>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com>
	<40D34078.5060909@pacbell.net>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 12:20:24 -0700
David Brownell <david-b@pacbell.net> wrote:

> For example, if usbaudio uses usb_buffer_alloc to stream data,
> that eliminates dma bouncing.  That's dma_alloc_coherent at
> its core ... it should allocate from that 32K region.

Agreed.
