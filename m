Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDMQIS>; Fri, 13 Apr 2001 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRDMQII>; Fri, 13 Apr 2001 12:08:08 -0400
Received: from npt12056206.cts.com ([216.120.56.206]:34059 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S131477AbRDMQH7>; Fri, 13 Apr 2001 12:07:59 -0400
Date: Fri, 13 Apr 2001 09:07:52 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Message-ID: <20010413090751.E4557@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041317365500.00665@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041317365500.00665@debian>; from ujq7@rz.uni-karlsruhe.de on Fri, Apr 13, 2001 at 05:36:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 05:36:55PM +0200, Andreas Peter wrote:
> Mark Hahn schrieb:
> > > hdparm -t /dev/md0 : 20.25 MB/sec
> > > hdparm -t /dev/hda : 20.51 MB/sec
> > > hdaprm -t /dev/hdc : 20.71 MB/sec
> >
> > md0 is composed of partitions located where on hda and hdc?
> > also, what's your CPU?
> 
> This is my raidtab file:

<snip>

Cconfig and setup looks OK.

What happens if your run hdparm -t /dev/hda and /dev/hdc at the same time?

-Dave
