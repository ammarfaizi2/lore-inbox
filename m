Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbSKERNO>; Tue, 5 Nov 2002 12:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbSKERNO>; Tue, 5 Nov 2002 12:13:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264959AbSKERNL>;
	Tue, 5 Nov 2002 12:13:11 -0500
Message-ID: <3DC7FD95.5000903@pobox.com>
Date: Tue, 05 Nov 2002 12:19:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>  
>
>Hmmm:
>
>axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
>641:CONFIG_NFSD_V4=y
>axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
>axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
>641:CONFIG_NFSD_V4=n
>

'=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...

or, just delete it.  that's what I do :)  the configurator will 
re-prompt for it, and I hit 'n'

yeah, nfsd build is still broken here too :)


