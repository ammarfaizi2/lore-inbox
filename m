Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267770AbTAIVCQ>; Thu, 9 Jan 2003 16:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTAIVCQ>; Thu, 9 Jan 2003 16:02:16 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:59133
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267770AbTAIVCP>; Thu, 9 Jan 2003 16:02:15 -0500
Message-ID: <3E1DE55F.81DE9324@eyal.emu.id.au>
Date: Fri, 10 Jan 2003 08:10:55 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre2-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21pre3-ac2 - some trivial patches
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
		 <3E1D5BF9.D537AA23@eyal.emu.id.au> <1042134064.27796.18.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Thu, 2003-01-09 at 11:24, Eyal Lebedinsky wrote:
> > A few small patches that I needed to finish a build on Debian 3.0.
> 
> >
> > ______________________________________________________________________
> The ehci one you didnt provide in diff -u but seems to be a compiler problem.
> If so the fix is to make ehci_warn/info safe for ancient gcc.

Yes, Debian still has an old compiler
	gcc version 2.95.4 20011002 (Debian prerelease)
and my reported problems should simply show the difficulties
it encounters.

So what is the proper workaround for this specific compiler bug?
I guess "args..." requires at least one arg or it errors.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
