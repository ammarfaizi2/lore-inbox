Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131790AbRCOTSX>; Thu, 15 Mar 2001 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131793AbRCOTSO>; Thu, 15 Mar 2001 14:18:14 -0500
Received: from raven.toyota.com ([63.87.74.200]:23310 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131790AbRCOTSC>;
	Thu, 15 Mar 2001 14:18:02 -0500
Message-ID: <3AB1153F.802BEBA9@toyota.com>
Date: Thu, 15 Mar 2001 11:17:19 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <Pine.LNX.4.33.0103152304570.1320-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 15 Mar 2001, J Sloan wrote:
>
> > There are some scheduler patches that are not part of the
> > main kernel tree at this point (mostly since they have yet to
> > be optimized for the common case) which make quite a big
> > difference under heavy load - you might want to check out:
> >
> >     http://lse.sourceforge.net/scheduling/
>
> Unrelated.   Fun, but unrelated to networking...

Fun, yes, and perhaps not directly related, however
under high load, where the sheer numbet of interrupts
per second begins to overwhelm the kernel, might it
not be relevant? After all, the benchmarks do point to
tangible improvements in the performance of network
server apps.

Or are you saying that the bottleneck is somewhere
else completely, or that there wouldn't be a bottleneck
in this case if certain kernel parameters were correctly
set?

Just curious,

Jup


