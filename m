Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293424AbSCGFHo>; Thu, 7 Mar 2002 00:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293482AbSCGFHY>; Thu, 7 Mar 2002 00:07:24 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:36743 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S293424AbSCGFHS>;
	Thu, 7 Mar 2002 00:07:18 -0500
Message-ID: <3C86F566.70603@tmsusa.com>
Date: Wed, 06 Mar 2002 21:06:46 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC
In-Reply-To: <3C82148E.E530824@wanadoo.es> <3C825A19.5070204@tmsusa.com> <20020306111502.D8107@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:

>Ah, I bet you didn't live through the truly atrocious 3Com drivers of
>the past. ;)  The new 3Com stuff seems passable for desktops, but having
>been bitten dozens of times, I'm about 4^4^4^4 times shy.
>
I didn't really start using 3coms until
a couple of years ago...

>That's all logged (dmesg, etc), if not distinctly queryable.  Don't the
>iANS tools allow this functionality, and more?
>
yes, you can grope through the logs (as part of
the process of puzzling it out) and there are
ways to get the information - but it's so much
nicer to just get the speed and duplex from
an mii-command, on the spot.


>
>
>Oh, and six years of production on hundreds of EtherExpress NICs with
>zero (0) issues.  Obviously, not everyone sees every bug, but the
>preponderance of evidence I've seen in production environments puts the
>EE way ahead of 3Com.  
>
Well, like I say it's a mixed bag. We have mail/dns
servers (580 dns domains, 100,000 messages/day)
that have been runing for over 600 days, and not
a hint of trouble from the eepro100 drivers.

OTOH we have some new dell boxes with intel
pro 100 nics where we can quickly get the "eth0
reports no resources" message and poor or no
connectivity with a couple hours of apachebench
on a 100 MB lan.

could be a chipset issue...

>3Com for Windows desktops works just fine.
>
windoze desktops? give them ne2000s, who cares.

>
>I'd like to try existing Tulip hardware though for another option.
>Though 8139too seems to work well.
>

I've heard the horror stories about realtek
cards, but they seem to work well for me -

Joe


