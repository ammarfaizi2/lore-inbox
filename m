Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVGGN6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVGGN6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVGGN4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:56:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59064 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261560AbVGGNyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:54:52 -0400
Date: Thu, 7 Jul 2005 15:56:23 +0200
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: raja <vnagaraju@effigent.net>, linux-kernel@vger.kernel.org
Subject: Re: function Named
Message-ID: <20050707135621.GC24401@suse.de>
References: <42CD25FA.6030100@effigent.net> <Pine.LNX.4.61.0507070939200.9975@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507070939200.9975@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Richard B. Johnson wrote:
> On Thu, 7 Jul 2005, raja wrote:
> 
> >hi,
> >   Is there any way to get the function address by only knowing the
> >function Name
> >thanking you,
> >-
> 
> 	printf("%p\n", function());   // User code
> 	printk("%p\n", function());   // Kernel code

Yup that'll work fine, provided 'function' takes no arguments and
returns its own address.

-- 
Jens Axboe

