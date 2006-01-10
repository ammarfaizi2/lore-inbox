Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWAJQwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWAJQwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWAJQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:52:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751144AbWAJQwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:52:54 -0500
Date: Tue, 10 Jan 2006 08:52:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <43C3E376.3020303@rtr.ca>
Message-ID: <Pine.LNX.4.64.0601100851390.4939@g5.osdl.org>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
 <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
 <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
 <43C3E376.3020303@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Mark Lord wrote:
> 
> Are "DEFAULT_*" really the best names to assign to these options?
> For these options, I'd expect something like "VMUSER_*" or "USERMEM_*".

Good point. I just took the naming from the original one. Especially if 
all the logic is moved into Kconfig files, it has nothing to do with 
DEFAULT what-so-ever. More of a VMSPLIT_3G or similar..

		Linus
