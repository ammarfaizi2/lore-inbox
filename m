Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282819AbRLRNnQ>; Tue, 18 Dec 2001 08:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRLRNnG>; Tue, 18 Dec 2001 08:43:06 -0500
Received: from rdu57-8-218.nc.rr.com ([66.57.8.218]:42368 "EHLO joe.krahn")
	by vger.kernel.org with ESMTP id <S282819AbRLRNm4>;
	Tue, 18 Dec 2001 08:42:56 -0500
Message-ID: <3C1F47D4.8964A190@nc.rr.com>
Date: Tue, 18 Dec 2001 08:42:44 -0500
From: Joe Krahn <jkrahn@nc.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13j1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Common removable media interface?
In-Reply-To: <3C1F41D6.43A16F80@nc.rr.com> <20011218142002.C32511@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Dec 18 2001, Joe Krahn wrote:
> > I think Linux could use a common removable
> > media interface, sort of like cdrom.c adds
...
> 
> Stuff like this belongs in user space, no need to bloat the kernel with
> it.
> 
> --
> Jens Axboe
OK, you are right. Bloat is bad. So,
would you say that new drivers should keep ioctls
to a bare minimum, much less than cdrom.c, and just
provide generic access, like SG_IO/HDIO_DRIVE_CMD,
as a general rule from now on?
(Sounds OK to me...)

Joe Krahn
