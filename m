Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSKCOuX>; Sun, 3 Nov 2002 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSKCOuX>; Sun, 3 Nov 2002 09:50:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10431 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261973AbSKCOuW>;
	Sun, 3 Nov 2002 09:50:22 -0500
Date: Sun, 3 Nov 2002 15:56:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Luc Saillard <luc.saillard@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021103145640.GN3612@suse.de>
References: <20021102210103.GA25617@cedar.alcove-fr> <20021102213448.GA3612@suse.de> <20021103002346.GA25842@cedar.alcove-fr> <20021103094052.GI3612@suse.de> <20021103144217.GA9008@cedar.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103144217.GA9008@cedar.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Luc Saillard wrote:
> On Sun, Nov 03, 2002 at 10:40:52AM +0100, Jens Axboe wrote:
>  
> > please reproduce with this debug patch and send me the output:
> > 
>  
> I've no problem with your patch. I've burn 5 cds without problems.
> 
> Here my ouput for a record:
> hdc: 5a, ptr=cf3a7c00,len=2,bio=00000000

[snip]

Hmm great, heisenbug. Could you send me the complete dump of what
happens? Just want to see if something sticks out, that could perhaps
trigger a bug somewhere. A private mail is probably best :)

-- 
Jens Axboe

