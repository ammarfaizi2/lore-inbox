Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDGTdh>; Sat, 7 Apr 2001 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRDGTd2>; Sat, 7 Apr 2001 15:33:28 -0400
Received: from front7m.grolier.fr ([195.36.216.57]:3988 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S130507AbRDGTdN> convert rfc822-to-8bit; Sat, 7 Apr 2001 15:33:13 -0400
Date: Sat, 7 Apr 2001 18:22:15 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Tim Waugh <twaugh@redhat.com>
cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        mj@suse.cz, reinelt@eunet.at, jgarzik@mandrakesoft.com
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <20010407200340.C3280@redhat.com>
Message-ID: <Pine.LNX.4.10.10104071816560.1771-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Apr 2001, Tim Waugh wrote:

> On Sat, Apr 07, 2001 at 08:42:35PM +0200, Gunther Mayer wrote:
> 
> > Please apply this little patch instead of wasting time by
> > finger-pointing and arguing.
> 
> This patch would make me happy.
> 
> It would allow support for new multi-IO cards to generally be the
> addition of about two lines to two files (which is currently how it's
> done), rather than having separate mutant hybrid monstrosity drivers
> for each card (IMHO)..

It is possible to design a single function PCI device that is able to do
everything. Your approach is just encouraging this kind of monstrosity.
Such montrosity will look like some single-IRQ capable ISA remake, thus
worse than 20 years old ISA.

If we want to encourage that, then we want to stay stupid for life, in my
nervous opinion.

  Gérard.


