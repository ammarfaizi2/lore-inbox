Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135786AbRDYB02>; Tue, 24 Apr 2001 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135788AbRDYB0J>; Tue, 24 Apr 2001 21:26:09 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:18636 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S135786AbRDYBZ6>;
	Tue, 24 Apr 2001 21:25:58 -0400
Date: Tue, 24 Apr 2001 18:25:50 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: orinoco_cs & IrDA
Message-ID: <20010424182550.A32286@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010424113920.B31666@bougret.hpl.hp.com> <E14s8mc-0002n9-00@the-village.bc.nu> <20010424151508.C31898@bougret.hpl.hp.com> <20010424155637.D31898@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424155637.D31898@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Apr 24, 2001 at 03:56:37PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 03:56:37PM -0700, Jean Tourrilhes wrote:
> On Tue, Apr 24, 2001 at 03:15:08PM -0700, Jean Tourrilhes wrote:
> > 
> [...]
> > 	Downloaded the patch again (patch-2.4.4-pre6), checked that it
> > was complete, my patch is in. Oups ! Do I feel stupid...
> 
> 	Let's finish this story. As indicated above, the first
> fragment of the patch I sent on month ago is in the kernel. The two
> other fragments didn't make it. They are attached...

	Ok, now to the second chapter. These are all the changes
accumulated since the patch I sent one month ago (cf previous e-mail).
	Changes :
		o more Prism2/Symbol compatibility goodies
		o Tested D-Link cards and Lucent firmware 7.28
		o Cleanup, bug fixes from David Gibson
	The whole is tested, as usual... 75% of the patch was on my
web pages for the last month and people seem to have liked it.

	I've made 2 patches, one for 2.4.4-pre6 and one for
2.4.3-ac13. The difference between the two is minor (one line).

	Linus : please have a look at orinoco_v4b.diff (first
attachement). Of course, this patch will apply and work only if you
have applied the patch in my previous e-mail.

	Alan : orinoco_v4b-alan.diff is for you (second attachement).

	Have fun...

	Jean
