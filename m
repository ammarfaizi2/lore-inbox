Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135397AbRDMEnz>; Fri, 13 Apr 2001 00:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135398AbRDMEnf>; Fri, 13 Apr 2001 00:43:35 -0400
Received: from altus.drgw.net ([209.234.73.40]:2064 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S135397AbRDMEn2>;
	Fri, 13 Apr 2001 00:43:28 -0400
Date: Thu, 12 Apr 2001 23:42:19 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>, linux-kernel@vger.kernel.org
Subject: natsemi.c still broken...
Message-ID: <20010412234219.Z13920@altus.drgw.net>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B59@mail0.myrio.com> <3AC22661.E69BE205@mandrakesoft.com> <20010411213236.P13920@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010411213236.P13920@altus.drgw.net>; from hozer@drgw.net on Wed, Apr 11, 2001 at 09:32:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 09:32:36PM -0500, Troy Benjegerdes wrote:
> On Wed, Mar 28, 2001 at 12:58:57PM -0500, Jeff Garzik wrote:
> > There are some improvements in the latest 2.4 test patch, 2.4.3-pre8.  I
> > would be very interested in hearing feedback on that.  I finally got two
> > test cards, FA311 and FA312, so I can work on it a bit too.
> 
> Okay, I finally got around to testing this on 2.4.4-pre1. for the 5 or so 
> minutes I've been using it so far, it seems okay (I'm able to log in this 
> time), and I'm running NetPIPE to check performance.
> 
> Perfomance isn't great (the peak bandwidth is 65 Mbps or so), but this
> could be partially due to my switch or the other machine I'm testing it
> with.

Okay, I've been running with 2.4.4-pre1 for awhile now, and although the
driver does hang up on nfs traffic, it still has problems. After running
for awhile, it seems to have dropouts of server hundred milliseconds where
no packets go through. This is somewhat evident in interactive SSH
sessions, and causes clients connecting to the squid proxy I am running on
the machine to behave quite badly. (debian's 'apt' via the proxy is
particulaly bad)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
