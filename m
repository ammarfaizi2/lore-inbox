Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbSLLUV1>; Thu, 12 Dec 2002 15:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbSLLUV0>; Thu, 12 Dec 2002 15:21:26 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:14355 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267478AbSLLUVY>; Thu, 12 Dec 2002 15:21:24 -0500
Date: Thu, 12 Dec 2002 20:29:16 +0000
To: Wil Reichert <wilreichert@yahoo.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
Message-ID: <20021212202916.GA28717@reti>
References: <1039572597.459.82.camel@darwin> <20021212120836.GA5717@reti> <1039718098.433.13.camel@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039718098.433.13.camel@darwin>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 01:34:59PM -0500, Wil Reichert wrote:
> Yeah, ditching patch 5 makes my lvm functional again.  Things are
> definately better now.  I haven't attempted to stress it, but the entire
> hanging console / zombie process bit has gone away.  Everything appears
> to work normally.  A couple test cp's shows nothing abnormal, but
> playing an ogg still results in the following.
> 
> Dec 12 13:32:20 darwin kernel: bio too big device ide2(33,0) (256 > 255)
> Dec 12 13:32:51 darwin last message repeated 3 times
> Dec 12 13:33:55 darwin last message repeated 6 times
> 
> Any other tests I should do?

I'm now seeing some corruption with large files, so I'll fix that and
hope that it solves your problem too.  wrt. the device size bug that
you're experiencing could you mail me (not the list) your .config
please ?

- Joe
