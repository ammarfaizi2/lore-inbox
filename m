Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUIPPWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUIPPWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIPPRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:17:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268180AbUIPPEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:04:11 -0400
Date: Thu, 16 Sep 2004 17:02:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-ck7-web100] Badness in cfq_sort_rr_list
Message-ID: <20040916150228.GG3544@suse.de>
References: <1072359679.20040916142632@dns.toxicfilms.tv> <20040916125824.GD3544@suse.de> <569683048.20040916165042@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569683048.20040916165042@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim cc lists... people don't have time to watch linux-kernel all
day)

On Thu, Sep 16 2004, Maciej Soltysiak wrote:
> > You can ignore it, it's harmless. Con has the extra updates to fix this,
> > they are also in 2.6.9-rc2-mm1 as posted by Andrew earlier today.
> Harmless you say... :-) The machine almost hardlocked. I could only
> type my username during login and that's all.
> Maybe it is unrelated but I will try the suggested patch.

Probably unrelated. It can cause some starvation, that should be the
worst effect.

-- 
Jens Axboe

