Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbREYVSF>; Fri, 25 May 2001 17:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261915AbREYVRp>; Fri, 25 May 2001 17:17:45 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58663
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261910AbREYVRo>; Fri, 25 May 2001 17:17:44 -0400
Date: Fri, 25 May 2001 23:17:37 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add missing spin_unlock_irq to ide.c (244ac16)
Message-ID: <20010525231737.P851@jaquet.dk>
In-Reply-To: <20010525225934.K851@jaquet.dk> <20010525231123.C22714@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010525231123.C22714@suse.de>; from axboe@suse.de on Fri, May 25, 2001 at 11:11:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 11:11:23PM +0200, Jens Axboe wrote:
[...] 
> This isn't right. Granted the locking isn't straight forward here, but
> take a look at ide_write_setting -> ide_spin_wait_hwgroup and the
> latters return value.
 
Yes, Andre set me straight here. My apologies for being lazy and
not checking the call path.

-- 
        Rasmus(rasmus@jaquet.dk)

You know how dumb the average guy is?  Well, by  definition, half
of them are even dumber than that.
            -- J.R. "Bob" Dobbs 
