Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJLJsZ>; Sat, 12 Oct 2002 05:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262867AbSJLJsY>; Sat, 12 Oct 2002 05:48:24 -0400
Received: from gw.openss7.com ([142.179.199.224]:28433 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262862AbSJLJsY>;
	Sat, 12 Oct 2002 05:48:24 -0400
Date: Sat, 12 Oct 2002 03:54:06 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
Cc: Ole Husgaard <osh@sparre.dk>, Christoph Hellwig <hch@infradead.org>,
       David Grothe <dave@gcom.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       Dave Miller <davem@redhat.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Message-ID: <20021012035406.A14955@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjanv@fenrus.demon.nl>,
	Ole Husgaard <osh@sparre.dk>, Christoph Hellwig <hch@infradead.org>,
	David Grothe <dave@gcom.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>,
	Dave Miller <davem@redhat.com>
References: <5.1.0.14.2.20021010115616.04a0de70@localhost> <4386E3211F1@vcnet.vc.cvut.cz> <5.1.0.14.2.20021010115616.04a0de70@localhost> <20021010182740.A23908@infradead.org> <5.1.0.14.2.20021010140426.0271c6a0@localhost> <20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org> <3DA78926.FB2299A@sparre.dk> <1034415141.2962.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1034415141.2962.0.camel@localhost.localdomain>; from arjanv@fenrus.demon.nl on Sat, Oct 12, 2002 at 11:32:21AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan,

On Sat, 12 Oct 2002, Arjan van de Ven wrote:

> On Sat, 2002-10-12 at 04:29, Ole Husgaard wrote:
> > "Brian F. G. Bidulock" wrote:
> > > On Fri, 11 Oct 2002, Christoph Hellwig wrote:
> > > > It is not.  Sys_call_table was exported to allow iBCS/Linux-ABI
> > > 
> > > I don't know if it matters, but these two calls putpmsg and getpmsg
> > > are the calls used by iBCS.
> > 
> > AFAIK, iBCS use these syscalls to emulate TLI, and iBCS
> iBCS doesn't exist for 2.4 or 2.5 kernels
> it's called linux-abi now and does NOT use these syscalls

This is true, but there is a large chunk of iBCS code still under
the sparc archictecture under solaris.  This code is not linked
into the putpmsg or getpmsg syscalls, but is still distributed with
the kernel.  As it is unused, will this code be removed?  Or, has it
already been removed in 2.5 kernels?

- --brian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9p/E8MYOP2up1d2URAkl+AJ4/4s8+wXsT/mn4EQODKQffWygJpgCg5DDu
SZlzwCYroXY48cibs/dEf/8=
=zPWr
-----END PGP SIGNATURE-----
