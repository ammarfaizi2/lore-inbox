Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284014AbRLAJCi>; Sat, 1 Dec 2001 04:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284015AbRLAJC2>; Sat, 1 Dec 2001 04:02:28 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49397
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284014AbRLAJCS>; Sat, 1 Dec 2001 04:02:18 -0500
Date: Sat, 1 Dec 2001 01:02:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Is it normal for freezing while...
Message-ID: <20011201010212.G489@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>, war <war@starband.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C085B04.50ABE0B5@starband.net> <3C0867A3.5119D2BC@zip.com.au> <3C087023.9683B8AF@starband.net> <3C0875DA.A54BC89E@zip.com.au> <20011201002631.F489@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201002631.F489@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 12:26:31AM -0800, Mike Fedyk wrote:
> On Fri, Nov 30, 2001 at 10:16:58PM -0800, Andrew Morton wrote:
> > Being a cautious chap, I think I'll submit that patch, with
> > the default setting to "off", so there is no change to default
> > kernel behaviour.   Then people can run `elvtune -b' to enable it.
> > 
> 
> Hmm...
> 
> mikef-linux:/home/mfedyk# elvtune /dev/hda
> 
> /dev/hda elevator ID            0
>         read_latency:           8192
>         write_latency:          16384
>         max_bomb_segments:      0
> 
....

As pointed out on irc, and in email, Andrew's elevator patch wasn't in
2.4.17-pre2...

False alarm. :)
