Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbREWVV6>; Wed, 23 May 2001 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263268AbREWVVt>; Wed, 23 May 2001 17:21:49 -0400
Received: from intranet.resilience.com ([209.245.157.33]:53634 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S263260AbREWVVn>; Wed, 23 May 2001 17:21:43 -0400
Message-ID: <3B0C2AB0.F374FC68@resilience.com>
Date: Wed, 23 May 2001 14:25:04 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David N. Lombard" <david.lombard@mscsoftware.com>
CC: Patric Mrawek <mrawek@punkt.de>, linux-kernel@vger.kernel.org
Subject: Re: Boot Problem
In-Reply-To: <20010523140356.A38056@punkt.de> <3B0C21C6.A78FEDB6@mscsoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David N. Lombard" wrote:
> 
> Patric Mrawek wrote:
> >
> > Hi,
> >
> > sometimes one of my servers doesn't boot correctly. Lilo reads the
> > kernel-image, but doesn't decompress it. So the system won't
> > continue booting.
> >
> > Looks like:
> > Loading linux...................
> > (at this point the machine freezes)
> 
> Our experience of this has been with suspect hardware.  It was our first
> (pre-release) P4 system, so we puzzled over it for a short while; later
> testing on other P4 systems showed no such problem.
> 

This could also be from disabling "VGA text console" support in the
kernel.  The last message you will see on the VGA console is the
"Loading linux......." if you've disabled this feature.

However, if the problem is intermittent, this probably isn't the issue.

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
