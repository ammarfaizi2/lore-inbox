Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277965AbRJIUzW>; Tue, 9 Oct 2001 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277963AbRJIUzN>; Tue, 9 Oct 2001 16:55:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1263
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277967AbRJIUzD>; Tue, 9 Oct 2001 16:55:03 -0400
Date: Tue, 9 Oct 2001 13:55:28 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11.p4 and dd
Message-ID: <20011009135528.A20914@mikef-linux.matchmail.com>
Mail-Followup-To: kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110081343280.1775-100000@boris.prodako.se> <3BC2A130.CFEBBE2D@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC2A130.CFEBBE2D@isg.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 09:03:12AM +0200, Constantin Loizides wrote:
> Hi!
> 
> > > 2.4.3 uses a large amount of buffer, 2.4.11p4 only chache.
> > 
> > Block devices are handled by the page cache in 2.4.10 and up.
> > 
> 
> Eh, did I miss something? 

Yes.

>Thought, that meta data are still
> cached in buffer cache?

FSes still use the buffer cache, but the block devices now use page cache.

>Did it change from 2.4.9 to 2.4.10?

Yes, in 2.4.10pre11

> What about the ac kernels? 
>

Block devices use Buffer Cache.  Alan has stated that he doesn't plan to
merge this change any time soon, if at all.

> Constantin

Mike
