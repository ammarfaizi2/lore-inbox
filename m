Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDPQhJ>; Mon, 16 Apr 2001 12:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDPQg7>; Mon, 16 Apr 2001 12:36:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29198 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131479AbRDPQgv>;
	Mon, 16 Apr 2001 12:36:51 -0400
Date: Mon, 16 Apr 2001 18:36:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/block/loop.c:max_loop
Message-ID: <20010416183637.G9539@suse.de>
In-Reply-To: <20010416173942.G6934@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010416173942.G6934@informatics.muni.cz>; from kas@informatics.muni.cz on Mon, Apr 16, 2001 at 05:39:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16 2001, Jan Kasprzak wrote:
> 	Hello,
> 
> 	I run a relatively large FTP server, and I've just reached
> the max_loop limit of loop devices here (I use loopback mount of ISO 9660
> images of Linux distros here). Is there any reason for keeping
> the max_loop variable in loop.c set to 8?

Memory requirements -- nothing prevents you from loading it with a
bigger max count though...

-- 
Jens Axboe

