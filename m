Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbREOJLL>; Tue, 15 May 2001 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262698AbREOJLC>; Tue, 15 May 2001 05:11:02 -0400
Received: from 20dyn175.com21.casema.net ([213.17.90.175]:37124 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S262693AbREOJKT>;
	Tue, 15 May 2001 05:10:19 -0400
Date: Tue, 15 May 2001 11:09:40 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 To Pending Device Number Registrants
Message-ID: <20010515110940.A14060@home.ds9a.nl>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010515094835.A13650@home.ds9a.nl> <E14zabB-0002DM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <E14zabB-0002DM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 15, 2001 at 09:54:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 09:54:33AM +0100, Alan Cox wrote:
> > So I would think that this block of new major number allocations holds for
> > 2.5 and not 2.4. Also, if I'm correct, 2.4 won't be needing a lot of new
> > major numbers anyhow.
> 
> I wouldnt bet on that. Going to a 32bit dev_t internally without user space
> noticing would keep it seems to be quite doable if we have to. Right now doesnt
> worry me, in 2 years time when 2.6 is approaching release the picture might
> have changed a fair bit

I think that we then have two distinct problems: 1) finding a solution for 2.4
that does not change userspace 2) finding a solution for 2.5/2.6 that is
Right.

Personally I'm not sure what 2.4 stands to gain from a redesign. While 2.4
is obviously developing, a stable series needs to solve real problems or
improve performance - I know the way major numbers are allocated right now
is ugly and doesn't scale very well. But is 2.4 the place to fix that?

So the question is: does this new policy hold for 2.4 as well and if so,
why.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
