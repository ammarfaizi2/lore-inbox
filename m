Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262377AbRENTDa>; Mon, 14 May 2001 15:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262388AbRENTDU>; Mon, 14 May 2001 15:03:20 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:24068 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S262377AbRENTDI>;
	Mon, 14 May 2001 15:03:08 -0400
Date: Mon, 14 May 2001 12:02:48 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: =?iso-8859-1?Q?Mads_Martin_J=F8rgensen?= <mmj@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH 2.4.4.ac9: Tulip net driver fixes
Message-ID: <20010514120248.A26094@lucon.org>
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com> <20010514112216.A25436@lucon.org> <20010514112407.E781@suse.com> <3B002595.76399CE4@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B002595.76399CE4@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, May 14, 2001 at 02:36:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 02:36:05PM -0400, Jeff Garzik wrote:
> Mads Martin Jørgensen wrote:
> > 
> > * H . J . Lu <hjl@lucon.org> [May 14. 2001 11:22]:
> > > On Sat, May 12, 2001 at 03:25:34PM -0400, Jeff Garzik wrote:
> > > > Attached is a patch against 2.4.4-ac8 which includes several fixes to
> > > > the Tulip driver.  This should fix the reported PNIC problems, as well
> > > > as problems with forcing media on MII phys and several other bugs.
> > >
> > > Your patch doesn't apply to 2.4.4-ac8 cleanly:
> > 
> > No, I noticed that too. But the 1.1.6 from
> > http://sourceforge.net/projects/tulip/ works fine here.
> 
> Attached is a patch against 2.4.4-ac9 which includes the changes found
> in tulip-devel 1.1.6...   (tulip-devel is sort of a misnomer; right now
> it's really just a staging and testing point for fixes which go straight
> into the tulip-stable series)
> 

THANKS. It works!

BTW, I cannot select both CONFIG_IP_PNP_DHCP and CONFIG_IP_PNP_BOOTP.
BOOTP doesn' work even if I pass "ip=bootp" to kernel. I will take
a look.


H.J.
