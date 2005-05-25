Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVEYVki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVEYVki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVEYVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:40:34 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:5135 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261183AbVEYVk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:40:29 -0400
Date: Wed, 25 May 2005 14:45:24 -0700
To: Tom Vier <tmv@comcast.net>, '@nietzsche.lynx.com
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525214524.GB30987@nietzsche.lynx.com>
References: <20050525205841.GB28913@zero> <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk> <20050525212538.GC28913@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525212538.GC28913@zero>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 05:25:38PM -0400, Tom Vier wrote:
> On Wed, May 25, 2005 at 11:05:05PM +0200, Esben Nielsen wrote:
> > Long interrupt handlers can be interrupt by _tasks_, not only other
> > interrupts! An audio application running in userspace can be scheduled
> > over an ethernet interrupt handler copying data from the
> > controller into RAM (without DMA).
> 
> Doesn't that greatly increase the risk of the hardware overrunning it's
> buffer?

If you have a broken device and associated driver yes. But it's not like
irq-threads are going to change that either way.

bill

