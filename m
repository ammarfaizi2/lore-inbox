Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWAZTKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWAZTKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWAZTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:09:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:27623 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964802AbWAZTJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:09:58 -0500
Date: Thu, 26 Jan 2006 20:09:57 +0100
From: Olaf Kirch <okir@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060126190957.GB32622@suse.de>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com> <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com> <20060126190236.GA12481@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126190236.GA12481@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 08:02:37PM +0100, Stefan Seyfried wrote:
> Will be in the next SUSE betas, so if anything breaks, we'll notice
> it.

I doubt it. As Jesse mentioned, e100_hw_init is called from e100_up,
so the call from e100_resume was really superfluous.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
