Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWBDW6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWBDW6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWBDW6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:58:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5896 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932575AbWBDW6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:58:03 -0500
Date: Sat, 4 Feb 2006 23:58:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: HEADS UP for QLA2100 users
Message-ID: <20060204225801.GD4528@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org> <20051027215313.GB7889@plap.qlogic.org> <20051028225155.GA13958@infradead.org> <20051028230303.GI15018@plap.qlogic.org> <1130542543.23729.160.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130542543.23729.160.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:35:43PM -0700, Badari Pulavarty wrote:
> On Fri, 2005-10-28 at 16:03 -0700, Andrew Vasquez wrote:
> > On Fri, 28 Oct 2005, Christoph Hellwig wrote:
> > 
> > > On Thu, Oct 27, 2005 at 02:53:13PM -0700, Andrew Vasquez wrote:
> > > 
> > > > I'm still in the process of ironing out the .bin distribution details
> > > > locally, but perhaps once we migrate to firmware-loading exclusively
> > > > via request_firmware(), the (small?) contigent of 2100 could use the
> > > > EF variant I referenced above.
> > > 
> > > You know, I'm in favour of getting firmware images in the kernel image,
> > > but what's the problem of simply downgrading the 2100 firmware until
> > > we get rid of the builtin firmware for all qla2xxx variants?
> > 
> > I have no problems with submitting 1.17.38 EF for inclusion upstream.
> > My only hope is that for the (other) 2100 user out there that use the
> > latest 2100 firmware and are not experiencing problems, the downgrade
> > does not break anything.
> > 
> > That's another reason I posed the following question:
> > 
> > > > Could I get another informal count of 2100 users who are still having
> > > > problems with qla2xxx?
> > 
> > Perhaps I should also ask:
> > 
> > 	Who's running 2100 cards with the latest qla2xxx driver and
> > 	are experiencing no problems?
> 
> Hmm.. I thought qla2xxx driver doesn't like qla2100. I had troubles
> getting my qla2100 cards to work with qal2xxx (9 months ago) and
> gave up and using only qla2200 and qla2300 card.
> 
> Is there a point in me going back and trying qla2100 ? (Ofcourse,
> I need to locate those cards).

Now that in 2.6.16-rc the recommended method for firmware loading in
qla2xxx is to load it from userspace, the firmware version problems 
should have become non-issues.

If ypu have hardware that works in 2.6.16-rc2 with the qlogicfc driver 
but not with the qal2xxx driver, a bug report would be appreciated.

> Thanks,
> Badari

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

