Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291265AbSBMAD5>; Tue, 12 Feb 2002 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291267AbSBMADr>; Tue, 12 Feb 2002 19:03:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59397 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291265AbSBMADd>;
	Tue, 12 Feb 2002 19:03:33 -0500
Message-ID: <3C69AD53.40F82438@mandrakesoft.com>
Date: Tue, 12 Feb 2002 19:03:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
        Matt Gauthier <elleron@yahoo.com>
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu> <20020212165504.A5915@devcon.net>,
			<20020212165504.A5915@devcon.net>; from aferber@techfak.uni-bielefeld.de on Tue, Feb 12, 2002 at 04:55:04PM +0100 <20020212204710.A7416@artax.karlin.mff.cuni.cz> <3C697A1D.4599DDE@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jan Hudec wrote:
> >
> > > I don't know if any filesystem currently relocates blocks if you
> > > overwrite a file, but it's certainly possible and allowed (everything
> > > else except the filesystem itself simply must not care where the data
> > > actually ends up on the disk).
> >
> > AFAIK, ext2 tries to defragment files when possible.
> 
> We wish.

ext2meta will defragment yer files for ya, though.  Coming soon to a
kernel near you :)

My home directory disk, a raid-1 mirror, just crossed 15 percent
fragmentation last week, I noticed...  The filesystem is maybe 1.5-2
years old.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
