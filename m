Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSBMTW5>; Wed, 13 Feb 2002 14:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSBMTWs>; Wed, 13 Feb 2002 14:22:48 -0500
Received: from [63.231.122.81] ([63.231.122.81]:62063 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288731AbSBMTWa>;
	Wed, 13 Feb 2002 14:22:30 -0500
Date: Wed, 13 Feb 2002 12:21:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Eugene Chupkin <ace@credit.com>
Cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
Message-ID: <20020213122159.A16078@lynx.turbolabs.com>
Mail-Followup-To: Eugene Chupkin <ace@credit.com>,
	linux-kernel@vger.kernel.org, tmeagher@credit.com
In-Reply-To: <20020212213119.A25535@lynx.turbolabs.com> <Pine.LNX.4.10.10202131058110.683-100000@mail.credit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202131058110.683-100000@mail.credit.com>; from ace@credit.com on Wed, Feb 13, 2002 at 11:05:32AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  11:05 -0800, Eugene Chupkin wrote:
> On Tue, 12 Feb 2002, Andreas Dilger wrote:
> > The other possibility with that much RAM is that the page tables are taking
> > up all of the low RAM.  Andrea has a patch to put the page tables into
> > higmem in the recent -aa kernels.
> 
> I got it, the 2.4.18pre2aa2/pte-highmem-5 but I can't seem to figure out
> what to patch this on, I tried patching it on to 2.2.17, 2.2.18-pre1,
> and 2.2.18-pre2. On all those I get a Hunk failed. Any feedback is
> appreciated.

You may need to use a whole bunch of -aa patches to get it to apply.  In
general, the -aa tree is tuned for large machines such as yours, so you
are probably better off getting the whole thing.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

