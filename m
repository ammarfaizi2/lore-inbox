Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSBJBZM>; Sat, 9 Feb 2002 20:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289142AbSBJBZC>; Sat, 9 Feb 2002 20:25:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289140AbSBJBYs>;
	Sat, 9 Feb 2002 20:24:48 -0500
Message-ID: <3C65CBDE.A9B60BBD@mandrakesoft.com>
Date: Sat, 09 Feb 2002 20:24:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus 
 compile in -pre4))
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au> <3C65C4C5.C287A3@mandrakesoft.com> <20020210005913.GA1993@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> 
> On Sat, Feb 09, 2002 at 07:54:29PM -0500, Jeff Garzik wrote:
> > Herbert Xu wrote:
> > >
> > > Setup your key with an empty passphrase should do the trick.
> >
> > Ug.  no.  That is way way insecure.
> >
> > Most modern distros have an ssh-agent running as a parent of all
> > X-spawned processed (including processes spawned by xterms).  So, one
> > only needs to run
> >       ssh-add ~/.ssh/id_dsa ~/.ssh/identity
> > once, and input your password once.  After that, no passwords are
> > needed.
> 
> This is fine for interactive use.  But for a daily cron job, it's
> just as insecure as no passphrases at all.

It is far easier to guess your private key with a blank passphrase.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
