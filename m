Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRBABrD>; Wed, 31 Jan 2001 20:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRBABqx>; Wed, 31 Jan 2001 20:46:53 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:20016 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129509AbRBABqj>; Wed, 31 Jan 2001 20:46:39 -0500
Date: Wed, 31 Jan 2001 19:46:36 -0600
From: Matthew Fredrickson <matt@frednet.dyndns.org>
To: Adrian Bridgett <adrian.bridgett@iname.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel PPP/Modem connection problems starting somewhere between 2.2.14(maybe 15) and 2.2.18
Message-ID: <20010131194636.A25294@frednet.dyndns.org>
In-Reply-To: <20010124173038.A23669@frednet.dyndns.org> <20010128194828.A13179@wyvern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128194828.A13179@wyvern>; from adrian.bridgett@iname.com on Sun, Jan 28, 2001 at 07:48:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 07:48:29PM +0000, Adrian Bridgett wrote:
> On Wed, Jan 24, 2001 at 17:30:38 -0600 (+0000), Matthew Fredrickson wrote:
> > I'm not positive if this is a bug, I'm only able to confirm this from one
> > other source.  Somewhere between (I can't remember exactly which kernel my
> > server started on) ~2.2.14(or 15) and 2.2.18 my ppp connection
> > periodically hangs and I have to restart the connection.  My situation is
> [snip]
> 
> Ditto.  Using evil winmodem here and Debian (ppp-2.4.0f-1).  2.2.19pre3 at
> the moment but it's been happening for a while.  Things seemed better when I
> turned on default-asyncmap, however it still occasionally goes belly up
> (almost _always_ when scping files out (uploading Debian packages)).  Last
> time I checked it also happend with my 28.8k USB modem (a normal modem, that
> one).
> 
> I've found a magic fix and when I've got time I'll try and burrow though the
> pppd source to try and find out why.  The magic fix? Turn on recording in
> pppd (i.e. add "record /tmp/foo"  to /etc/ppp/options).  I'd be interested
> if it fixes it for you.

I'm not positive, but so far, it looks like that fixed the problem.  I
don't know what would cause it to break like that, but I think I'm going
to go hunt around changelogs to see if there are any major changes in that
kernel version range.

-- 
Matthew Fredrickson AIM MatthewFredricks
ICQ 13923212 matt@NOSPAMfredricknet.net 
http://www.fredricknet.net/~matt/
"Everything is relative"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
