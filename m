Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280794AbRKBSy2>; Fri, 2 Nov 2001 13:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280793AbRKBSwn>; Fri, 2 Nov 2001 13:52:43 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:35984 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S280781AbRKBSv6>; Fri, 2 Nov 2001 13:51:58 -0500
Date: Fri, 2 Nov 2001 13:51:53 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols
Message-ID: <20011102135153.B24959@alcove.wittsend.com>
Mail-Followup-To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111020954.fA29sf413054@riker.skynet.be> <20011102102140Z280638-17408+9329@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011102102140Z280638-17408+9329@vger.kernel.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 12:22:37PM +0100, Sebastian Dröge wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi
> There are a more unresolved symbols in:

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.14-pre7/kernel/drivers/block/loop.o
> depmod:         unlock_page

	Also rd.o if you have that compiled as a module.

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.14-pre7/kernel/fs/isofs/isofs.o
> depmod:         unlock_page
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.14-pre7/kernel/fs/smbfs/smbfs.o
> depmod:         unlock_page
> 
> Bye
> 
> Am Freitag, 2. November 2001 11:53 schrieb jarausch@belgacom.net:
> > Hi,
> >
> > trying to build 2.4.14-pre7 breaks with the error message
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o depmod:
> > unlock_page
> >
> > during make modules_install.
> >
> > 2.4.14-pre6 is running fine here.
> >
> > Thank for hint,
> > Helmut Jarausch
> >
> > Inst. of Technology
> > RWTH Aachen
> > Germany

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
