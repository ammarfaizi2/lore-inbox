Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135218AbRAYAUi>; Wed, 24 Jan 2001 19:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRAYAU2>; Wed, 24 Jan 2001 19:20:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2569 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135218AbRAYAUU>;
	Wed, 24 Jan 2001 19:20:20 -0500
Date: Thu, 25 Jan 2001 01:13:40 +0100
From: Jens Axboe <axboe@suse.de>
To: First Name Last Name <qkholland@my-deja.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre10 Hard lockup writing to fs on loop devices
Message-ID: <20010125011340.A1096@suse.de>
In-Reply-To: <200101250002.QAA13445@mail3.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101250002.QAA13445@mail3.bigmailbox.com>; from qkholland@my-deja.com on Wed, Jan 24, 2001 at 04:02:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24 2001, First Name Last Name wrote:
> I am seeing hard lockup without OOPS when I write
> 60-40MB into a filesystem created on a regular file via
> loop device, and the problem is quite reproducible.
> Is anybody else suffering from a similar problem?

Yes, at least judging by the emails I've gotten about it
at least several others are seeing this too. And I can
reproduce it here. I'm working on the next patch, the
last one still had a deadlock.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
