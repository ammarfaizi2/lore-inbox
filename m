Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132569AbRDEQ6q>; Thu, 5 Apr 2001 12:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132583AbRDEQ6h>; Thu, 5 Apr 2001 12:58:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39049 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132569AbRDEQ6Y>;
	Thu, 5 Apr 2001 12:58:24 -0400
Message-ID: <3ACCA403.BFC86E41@mandrakesoft.com>
Date: Thu, 05 Apr 2001 12:57:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manuel A. McLure" <mmt@unify.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: tulip (was RE: Kernel 2.4.3 fails to compile)
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C169@pcmailsrv1.sac.unify.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manuel A. McLure" wrote:
> 
> Jeff Garzik wrote:
> > On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> > > It looks like the tulip driver isn't as up-to-date as the one from
> > > 2.4.2-ac20 - when is 2.4.3-ac1 due? :-) I got NETDEV
> > WATCHDOG errors shortly
> > > after rebooting with 2.4.3, although these were of the
> > "slow/packet lossy"
> > > type I got with 2.4.2-ac20 instead of the "network
> > completely unusable" type
> > > I got with 2.4.2-ac11 and earlier.
> >
> > I'm betting that the latest ac (ac28?) is broken for you, too.
> >
> > I had to revert the changes in 'ac' tulip -- they fixed Comet
> > and 21041
> > cards, but broke some others.  sigh.
> >
> > sigh.  More testing and debugging for Jeffro...  Comet (your chip, I
> > am guessing?) should be fixed ASAP, it's pretty easy.  21041 is not as
> > easy, but should be fixed quickly as well.
> 
> Yes, mine is a Comet - here's the exact detection message:
> 
> Mar 30 13:09:06 ulthar kernel: Linux Tulip driver version 0.9.14 (February
> 20, 2
> 001)
> Mar 30 13:09:06 ulthar kernel: PCI: Found IRQ 5 for device 00:0c.0
> Mar 30 13:09:06 ulthar kernel: eth0: ADMtek Comet rev 17 at 0xb000,
> 00:20:78:0D:
> D2:E1, IRQ 5.

Ok, this should be fixed in the latest patches sent to Alan and Linus.

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
