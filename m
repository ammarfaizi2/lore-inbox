Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUARU7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUARU7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:59:30 -0500
Received: from colin2.muc.de ([193.149.48.15]:62738 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263653AbUARU73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:59:29 -0500
Date: 18 Jan 2004 22:00:17 +0100
Date: Sun, 18 Jan 2004 22:00:17 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Sander <sander@humilis.net>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040118210017.GB68521@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius> <20040117212857.GA28114@colin2.muc.de> <20040118054442.GA32278@favonius> <20040118203459.GB8500@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118203459.GB8500@favonius>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no idea if it is hardware or software related, and if it has got
> anything to do with the REGPARM option, but I entered this thread
> because the kernel oopsed the first time I booted it and the first time
> I enabled this option.

Do the oopses go away when you disable the option? And do they come back
when you reenable it again? 

You could run memtest86 to make sure your RAM is ok.

-Andi
