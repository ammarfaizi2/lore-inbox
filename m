Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbRFKSkn>; Mon, 11 Jun 2001 14:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbRFKSkd>; Mon, 11 Jun 2001 14:40:33 -0400
Received: from [209.234.73.40] ([209.234.73.40]:530 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S263404AbRFKSkZ>;
	Mon, 11 Jun 2001 14:40:25 -0400
Date: Mon, 11 Jun 2001 13:39:49 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM PPC 405 series little endian?
Message-ID: <20010611133949.Q753@altus.drgw.net>
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188DE7@tcint1ntsrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188DE7@tcint1ntsrv>; from TZ@link.topcall.co.at on Mon, Jun 11, 2001 at 01:34:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 01:34:21PM +0200, Zehetbauer Thomas wrote:
> Has someone experimented with running linux in little-endian mode on IBM
> PowerPC 405 (Walnut) yet?

Well, first, I have to ask, why??

First, if you need to deal with little endian data, on a PPC stwbrx &
lwbrx are your friends.

With the possible exception of the matrox guy, I haven't heard of ANYONE 
running in LE mode on ppc. The second problem is going to be to recompile 
ALL the applications you want and hope they work.

Finally, if you're doing anything that connects to the internet, remember 
that network byte order is big-endian. You might find it interesting that 
even Intel is now re-discovering the usefullness of big-endian in some of 
their strongarm/Xscale processors.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
