Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRDHEmt>; Sun, 8 Apr 2001 00:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRDHEmk>; Sun, 8 Apr 2001 00:42:40 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:53691 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S132484AbRDHEma>; Sun, 8 Apr 2001 00:42:30 -0400
Date: Sun, 8 Apr 2001 00:42:07 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1
Message-ID: <20010408004206.A29133@sapience.com>
In-Reply-To: <20010407195031.B25801@sapience.com> <200104080139.f381dZs92143@aslan.scsiguy.com> <20010408001132.A28840@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010408001132.A28840@sapience.com>; from lists@sapience.com on Sun, Apr 08, 2001 at 12:11:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Well my aicxxx problems continue:

  I did it again and indeed verified similar error messages as I had
  under stock 2.4.3 and 2.4.3+aic 6.1.8. This time it died during boot itself
  starting with complaints from ssh/xinet et al - then I started seeing the
  scsi errors.  (I believe I had also tried ac26 with similar problems hwhich IIRC 
  is  6.1.5).

  Anyway, it goes around in a loop with stuff like:

  SCB 1 ...
  scsi ... 
  scsi   ... recovery complete ..
  scsi   ... code aweke ..
  scsi   ... aic7xxx_abort returns 8194

  or somwething similar. The aic7xxx_abort returns 8194 i remember exactly the others 
  I'm a bit shaky on. Anyway it seems to loop with the recovery/abort thing.

  What can I do to help track down the problem? 

  Regards,


  Gene/

  

-------------------------------------------------------------------

I enclose output of ver_linux - I note that it incorrectly reports util-linux
becuase it uses mount --version. On my redhat system mount is 2.10r while util-linux
is 2.10s-11. 


Linux snap 2.4.1-0.1.9 #1 Wed Feb 14 22:15:15 EST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0b
pcmcia-cs              3.1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         emu10k1 soundcore autofs joydev hid input 3c59x ipchains ide-scsi ide-cd cdrom usb-uhci usbcore aic7xxx sd_mod scsi_mod

-------------------------------------------------------------------


On Sun, Apr 08, 2001 at 12:11:32AM -0400, lists@sapience.com wrote:
> 
> I used 5000ms. I still freeze up with 2.4.3 + 6.1.10.
> 
> ...

