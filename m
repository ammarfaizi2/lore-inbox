Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRBYFFT>; Sun, 25 Feb 2001 00:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRBYFFJ>; Sun, 25 Feb 2001 00:05:09 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:59345 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129828AbRBYFE5>; Sun, 25 Feb 2001 00:04:57 -0500
Message-ID: <3A98926A.AB1C2243@uow.edu.au>
Date: Sun, 25 Feb 2001 16:04:42 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Igor Mozetic <igor.mozetic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x in 2.4.{0,1,2}
In-Reply-To: <14996.58045.843929.411743@ravan.camtp.uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Mozetic wrote:
> 
> There is probably just some miscoordination between the kernel
> mainteiners, but anyway. The 3c59x driver shipped with all
> official 2.4.x kernels lacks the 'medialock' feature.
> The result on 3c900 10M/combo cards can be unpleasant:
> kernel log fills up quickly and only reboot helps.
> However, Andrew's unofficial drivers at
> http://www.uow.edu.au/~andrewm/linux/ work fine so this is
> just a plea to include them into the official kernel.

The latest 3c59x driver is in the zerocopy patch, as well
as at the above site.

Until things converge I'd suggest that you run a zerocopy
kernel rather than updating just the driver.  We need the
testing.

Alexey has done wonders recently, and for 3com cards
a zerocopy kernel now performs at least as well as
a stock kernel.
