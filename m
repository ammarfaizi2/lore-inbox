Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264008AbRFFSfo>; Wed, 6 Jun 2001 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFFSff>; Wed, 6 Jun 2001 14:35:35 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:37085 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264014AbRFFSfU> convert rfc822-to-8bit; Wed, 6 Jun 2001 14:35:20 -0400
Date: Wed, 6 Jun 2001 19:35:18 +0100 (BST)
From: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
Reply-To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
To: Kurt Roeckx <Q@ping.be>
cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010606191726.B421@ping.be>
Message-ID: <Pine.SOL.3.96.1010606184337.19288A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Kurt Roeckx wrote:

> On Wed, Jun 06, 2001 at 10:57:57AM +0100, Dr S.M. Huen wrote:
> > On Wed, 6 Jun 2001, Sean Hunter wrote:
> > 
> > > 
> > > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> > > 
> > 
> > Do I understand you correctly?
> > ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> > at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> > drives.
> 
> Maybe you really should reread the statements people made about
> this before.
> 
I think you might do with a more careful quoting or reading of the thread
yourself before casting such aspersions.

I did not recommend swap use. I argued that it was not reasonable to
reject a  2*RAM swap requirement on cost grounds.  There are those who do
not think this argument adequate because of grounds other than
hardware cost (e.g. retrofitting existing farms, laptops with zillions of
OSes etc.)

> 
> That swap = 2 * RAM is just a guideline, you really should look
> at what applications you run, and how memory they use.  If you
> choise your RAM so that all application can always be in memory
> at all time, there is no need for swap.  If they can't be, the
> rule might help you.
> 
I think the whole argument of the thread is against you here.  It seems
that if you do NOT provide 2*RAM you get into trouble much earlier than
you expect (a few argue that even if you do you get trouble).  If it were
just a guideline that gracefully degraded your performance the other lot
wouldn't be screaming.

The whole screaming match is about whether a drastic degradation on using
swap with less than the 2*RAM swap specified by the developers should lead
one to conclude that a kernel is "broken".

To conclude, this is not a hypothetical argument about whether to operate
completely in core.  There's not a person on LKML who doesn't know running
in RAM is better than running swapping.   It is one where users do swap
but allocate a size smaller than that recommended and are adversely
affected.  It is about whether a kernel that reacts this way could be
regarded as stable.  Answe



