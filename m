Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHINpV>; Fri, 9 Aug 2002 09:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHINpU>; Fri, 9 Aug 2002 09:45:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25797 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311885AbSHINpU>;
	Fri, 9 Aug 2002 09:45:20 -0400
Date: Fri, 9 Aug 2002 15:48:39 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.30 IDE 115
Message-ID: <20020809134839.GO2243@suse.de>
References: <3D53AE13.7060907@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D53AE13.7060907@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09 2002, Marcin Dalecki wrote:
> - Fix small typo introduced in 113, which prevented CD-ROMs from
>   working altogether.

Have you fixed the sense reporting issue I told you about months ago?

> - Eliminate block_ioctl(). This code can't be shared in the way
>   proposed by this file. We will port it to the proper
>   blk_insert_request() soon. This will eliminate the _elv_add_request()
>   "layering violation".

What are you talking about?

-- 
Jens Axboe

