Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRB1XLZ>; Wed, 28 Feb 2001 18:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRB1XLP>; Wed, 28 Feb 2001 18:11:15 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:59396 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129339AbRB1XJQ>;
	Wed, 28 Feb 2001 18:09:16 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Michal Jaegermann <michal@harddata.com>
Date: Thu, 1 Mar 2001 00:07:45 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <C291BF3C67@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 01 at 15:47, Michal Jaegermann wrote:
> > > I have more checks to make before I will be fully satisfied but
> > > this looks like it.
> > ...
> > > System Performance Setting [Optimal, Normal]
> > ...
> > 
> > Try BIOS 1006. AFAIK 1005D changed some VIA values for 'optimal'.
> 
> Is that important here?  IDE drives in question were not connected to
> on-board controller but the Promise one.  Results seem to indicate
> that this 'optimal' was important here anyway.

VIA host-bridge, not VIA-IDE... It is important even if you use Promise
only - look back through archives, there must be something really wrong
with this motherboard.
 
> > And 1006 contains newer Promise BIOS - but I did not notice any difference:
> > Windows98 still do not boot if I connect harddisk to /dev/hdh :-(
> 
> There is at this moment Windows98 installation on /dev/hde1 and it boots
> so far.   It got installed and it was booting regardless with these
> "other" BIOS seetings.

Connect UDMA2 CDROM to hda and UDMA2 IDE to hdg. And then look how Win98
lockup after they print 'Starting Win98...'. But that's offtopic for 
linux-kernel.
                                      Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                
