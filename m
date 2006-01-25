Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWAYUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWAYUOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWAYUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:14:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:13510 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751202AbWAYUOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:14:51 -0500
Date: Wed, 25 Jan 2006 21:14:50 +0100
From: Olaf Kirch <okir@suse.de>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060125201450.GA15102@suse.de>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 11:37:40AM -0800, Jesse Brandeburg wrote:
> its an interesting patch, but it raises the question why does
> e100_init_hw need to be called at all in resume?  I looked back
> through our history and that init_hw call has always been there.  I
> think its incorrect, but its taking me a while to set up a system with
> the ability to resume.

I'll ask the folks here to give it a try tomorrow. But I suspect at
least some of it will be needed. For instance I assume you'll
have to reload to ucode when bringing the NIC back from sleep.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
