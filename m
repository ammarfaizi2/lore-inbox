Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJQApW>; Wed, 16 Oct 2002 20:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJQApW>; Wed, 16 Oct 2002 20:45:22 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:26328 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261576AbSJQApV>; Wed, 16 Oct 2002 20:45:21 -0400
Date: Wed, 16 Oct 2002 17:51:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021017005109.GV22117@nic1-pc.us.oracle.com>
References: <20021014135100.GD28283@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014135100.GD28283@suse.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:
> @@ -943,7 +1015,6 @@
>  	 */
>  	bh = blk_queue_bounce(q, rw, bh);

	I don't know why this only slightly bothered me until I oopsed.
This only bounces the superbh and certainly doesn't bounce all the
attendant bhs in the list.

Joel

-- 

"In the room the women come and go
 Talking of Michaelangelo."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
