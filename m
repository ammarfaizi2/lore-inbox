Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315241AbSEIXxJ>; Thu, 9 May 2002 19:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSEIXxI>; Thu, 9 May 2002 19:53:08 -0400
Received: from harddata.com ([216.123.194.198]:43537 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S315241AbSEIXxH>;
	Thu, 9 May 2002 19:53:07 -0400
Date: Thu, 9 May 2002 17:52:56 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: >12 drives in a RAID?
Message-ID: <20020509175256.A31674@mail.harddata.com>
In-Reply-To: <Pine.LNX.4.33.0205091610170.8430-100000@mail.pronto.tv> <20020509161656.G14435@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 04:16:56PM +0200, Jakob Østergaard wrote:
> On Thu, May 09, 2002 at 04:11:00PM +0200, Roy Sigurd Karlsbakk wrote:
> > hi
> > 
> > How can I use more than 12 drives in a RAID config? I need it!!!
> > 
> > Please cc: to me as I'm not on the list(s)
> 
> Yes.
> 
> Back in the "old days" with the old superblocks you couldn't.

Hm, the last time I looked a header used by kernels had space
for someting like 27 or 29 drives (I do not remember the exact
number) but its variant in 'raidtools' sources allowed indeed
only 12.  Synchronizing those headers to kernel values raised
a maximum number of disks in an array quite considerably.

  Michal
