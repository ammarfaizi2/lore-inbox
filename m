Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313536AbSDQLMb>; Wed, 17 Apr 2002 07:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313550AbSDQLMa>; Wed, 17 Apr 2002 07:12:30 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:7301 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S313536AbSDQLM3>; Wed, 17 Apr 2002 07:12:29 -0400
Date: Wed, 17 Apr 2002 13:12:28 +0200
From: bert hubert <ahu@ds9a.nl>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
Subject: Re: please merge 64-bit jiffy patches.
Message-ID: <20020417131228.A16445@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020417102828.D11817@outpost.ds9a.nl> <Pine.LNX.4.33.0204171258310.14333-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:07:49AM +0000, Tim Schmielau wrote:

> Rik van Riel correctly suggested to merge it in 2.5 first. I have a 
> forward-ported version, but it has a minor locking issue on UP.

I think that would be right. It touches a lot of code.

> Albert Cahalan suggested to get rid of locking at all by only updating the 
> high word from the timer interupt. I will try to code this on the weekend.

Smart.

> I'm sorry I had no time for lobbying the merge in the last month.

Anything I can do to help, just let me know. Right now I am actually facing
costs because of this issue, so I am very much in favour of saving those
costs 500 days from now :-)

Regards,

bert 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
