Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144583AbRA2Acc>; Sun, 28 Jan 2001 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144644AbRA2AcW>; Sun, 28 Jan 2001 19:32:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48652 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S144583AbRA2AcF>;
	Sun, 28 Jan 2001 19:32:05 -0500
Date: Mon, 29 Jan 2001 01:31:45 +0100
From: Jens Axboe <axboe@suse.de>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: D state after applying ps hang patch
Message-ID: <20010129013145.G12772@suse.de>
In-Reply-To: <3A74B6AE.C179050B@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A74B6AE.C179050B@linux.com>; from david@linux.com on Mon, Jan 29, 2001 at 12:17:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, David Ford wrote:
> kernel 2.4.0-ac12
> 
> # ps -eo user,pid,args,wchan|egrep "imap|update|procmail"
> root         7 [kupdate]        get_request_wait
> david      627 imapd            get_request_wait
> david      752 procmail -f linu down
> david      761 procmail -f linu down
> david      799 procmail -f linu down
> david      854 procmail -f linu down
> david      886 procmail -f linu down
> david      847 imapd            get_request_wait
> david     1079 procmail -f linu down
> david     3280 imapd            interruptible_sleep_on_locked
> david     3321 imapd            interruptible_sleep_on_locked
> 
> and the cpu load is artificially inflated to 9.17

Which patch specifically?

-- 
Jens Axboe
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
