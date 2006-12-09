Return-Path: <linux-kernel-owner+w=401wt.eu-S937052AbWLIQBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937052AbWLIQBx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 11:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937055AbWLIQBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 11:01:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2069 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937052AbWLIQBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 11:01:52 -0500
Date: Sat, 9 Dec 2006 17:01:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: Alejandro Riveira =?iso-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
Message-ID: <20061209160159.GA6090@stusta.de>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com> <1165406299.3233.436.camel@laptopd505.fenrus.org> <1165407548.5954.224.camel@titan.tbdnetworks.com> <20061206131003.GF24140@stusta.de> <20061209132742.7a25dcb5@localhost.localdomain> <1165679105.7455.116.camel@titan.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165679105.7455.116.camel@titan.tbdnetworks.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 04:45:04PM +0100, Norbert Kiesel wrote:
> On Sat, 2006-12-09 at 13:27 +0100, Alejandro Riveira Fernández wrote:
> > El Wed, 6 Dec 2006 14:10:03 +0100
> > Adrian Bunk <bunk@stusta.de> escribió:
> > 
> > > On Wed, Dec 06, 2006 at 01:19:08PM +0100, Norbert Kiesel wrote:
> > > > On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> > > > > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > > > > > be optimal for a machine with exactly 1GB memory (like my current
> > > > > > desktop). Why is that option only prompted for after selecting EMBEDDED
> > > > > > (which I normally don't select for desktop machines
> > > > > 
> > > > > because it changes the userspace ABI and has some other caveats.... this
> > > > > is not something you should muck with lightly 
> > > > > 
> > > > 
> > > > Hmm, but it's also marked EXPERIMENTAL. Would that not be the
> > > > sufficient?  Assuming I don't use any external/binary drivers and a
> > > > self-compiled kernel w//o any additional patches: is there really any
> > > > downside?
> > > 
> > > - Wine doesn't work (I'm not sure about VMSPLIT_3G_OPT, but
> > >                      VMSPLIT_2G definitely breaks Wine)
> > 
> >  I use VMSPLIT_3G_OPT=y and wine works just fine (only tested with one
> >  program). Edgy + 2.6.19-rc1
> > 
> > 
> > 
> > > - AFAIR some people reported problems with some Java programs
> > >   after fiddling with the vmsplit options
> > > 
> > > EMBEDDED isn't exactly the right way to hide it, but the vmsplit options 
> > > aren't something you can safely change.
> > > 
> 
> So far all first-hand experiences I heard of were positive (i.e. I did
> not get an emaail from anyone saying: It had a negative effect for me),
>...

As I said, VMSPLIT_2G does break Wine for me.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

