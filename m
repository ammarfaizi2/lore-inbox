Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264939AbUFAIzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbUFAIzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUFAIzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:55:11 -0400
Received: from holomorphy.com ([207.189.100.168]:58766 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264939AbUFAIzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:55:08 -0400
Date: Tue, 1 Jun 2004 01:54:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Bradford <john@grabjohn.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Michael Brennan <mbrennan@ezrs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040601085456.GJ2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Bradford <john@grabjohn.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
References: <40BB88B5.8080300@ezrs.com> <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk> <40BBB5F7.1010407@yahoo.com.au> <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk> <20040601083206.GI2093@holomorphy.com> <200406010850.i518o8PD000134@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406010850.i518o8PD000134@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Lee Irwin III <wli@holomorphy.com>:
>> So you can move userspace pages out of ZONE_DMA as-needed.

On Tue, Jun 01, 2004 at 09:50:08AM +0100, John Bradford wrote:
> But how does that improve performance before untouched RAM, (496788 in this
> example), is exhausted?
> In normal use, (almost always CPU bound), I've honestly never noticed any
> performance gain from having swap configured.  I must admit I haven't put
> a lot of effort recently in to looking at this, but I have never been able
> to reproduce these 'swap increases performance even with untouched RAM'
> claims.

Because ZONE_DMA, the lower 16MB is not all of RAM.


-- wli
