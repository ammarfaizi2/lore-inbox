Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUKDCPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUKDCPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbUKDCIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:08:42 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:58318 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262066AbUKDB6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:58:11 -0500
Date: Wed, 3 Nov 2004 17:59:59 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104015959.GA54786@gaz.sfgoth.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031901.28977.rmiller@duskglow.com> <87654m4clz.fsf@asmodeus.mcnaught.org> <200411031945.20894.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031945.20894.rmiller@duskglow.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller wrote:
> Couldn't ring 1 be used to make 
> sure an errant driver doesn't drop the kernel, at least on x86 machines?

Not really -- drivers could still do things like mis-program their associated
hardware making it do DMA writes all over kernel memory (just as one example)

Basically it'd add a lot of complexity (and inefficiency) without adding
much real safety.

-Mitch
