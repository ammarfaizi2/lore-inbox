Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUBKXUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUBKXUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:20:50 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:39161 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266242AbUBKXUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:20:48 -0500
Date: Wed, 11 Feb 2004 18:33:10 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [FAQ-PATCH] OE-QuoteFix (Was: Re: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct)
Message-ID: <20040211183310.A323@mail.kroptech.com>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F020E5F21@ausx2kmpc106.aus.amer.dell.com> <20040210122715.A31834@lists.us.dell.com> <20040210182631.A21504@mail.kroptech.com> <20040211121050.GC19047@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040211121050.GC19047@suse.de>; from axboe@suse.de on Wed, Feb 11, 2004 at 01:10:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 01:10:50PM +0100, Jens Axboe wrote:
> On Tue, Feb 10 2004, Adam Kropelin wrote:
> > On Tue, Feb 10, 2004 at 12:27:15PM -0600, Matt Domsch wrote:
> > > On Tue, Feb 10, 2004 at 12:06:03PM -0600, Stuart_Hayes@Dell.com wrote:
> > > > 
> > > > At risk of sounding stupid, how can a user space program check the type of
> > > > media (DVD vs. CD) that's in the drive?  I think that's what magicdev is
> > > > trying to do.
> > > > Thanks
> > > > Stuart
> > > 
> > > 
> > > Stuart, FYI, more linux-kernel ettiquite.
> > > 
> > > People much prefer to see a quoting style as above (date, from line,
> > > inline >-delimited note you're quoting, followed by non->-delimited
> > > text.  (Such as this).  Outlook doesn't do this very well, as it
> > > always wants to put your response at the top of the message, but with
> > > cut-n-paste you can make the messages look more like what l-k expects.
> > 
> > I find OE-QuoteFix and Outlook-QuoteFix do a nice job of making
> > Outlook Express and Outlook, respectively, more standards compliant in
> > this regard. In addition to fixing up the message quoting syntax to what
> > Matt described, they also cleanly handle line wraps. In short, they make
> > life much easier for those of us tied to Windows boxes at the office.
> > 
> > OE-QuoteFix:
> > http://home.in.tum.de/~jain/software/oe-quotefix/
> > 
> > Outlook-QuoteFix:
> > http://flash.to/outlook-quotefix/
> 
> Maybe it would be a good idea to have this info added to the FAQ, for
> those unfortunately individuals that cannot easily switch to a decent
> mua?

Here's a patch against the current version of the lkml FAQ.

Richard, I added myself as a contributor to keep consistent style, but
I have no problem if you just want to paste the text in somewhere
appropriate instead. Also feel free to rephrase as needed.

--Adam


--- index.html	Wed Feb 11 18:25:27 2004
+++ index.html.new	Wed Feb 11 18:25:11 2004
@@ -300,6 +300,10 @@
 <A HREF="mailto:andrebalsa@altern.org">Andrew D. Balsa</A>
 </LI>
 
+<LI><TT>ADK:</TT>
+<A HREF="mailto:akropel1@rochester.rr.com">Adam D. Kropelin</A>
+</LI>
+
 <LI><TT>CP :</TT>
 <A HREF="mailto:colin@nyx.net">Colin Plumb</A>
 </LI>
@@ -2911,6 +2915,18 @@
 </LI>
 
 <LI>
+<FONT COLOR="#0000FF">(ADK)</FONT>
+Outlook and Outlook Express are particularly broken with regard to
+proper reply quoting style.
+<A HREF="http://flash.to/outlook-quotefix/">Outlook-QuoteFix</A>
+and <A HREF="http://home.in.tum.de/~jain/software/oe-quotefix/">
+OE-QuoteFix</A> are a couple of useful tools that make
+corresponding on linux-kernel easier for people forced to use
+these damaged mailers. In addition to fixing up the message
+quoting syntax, they also cleanly handle line wraps.
+</LI>
+
+<LI>
 <FONT COLOR="#0000FF">(REG)</FONT>
 Please don't use tabs or multiple spaces to quote text. Use the
 "<TT>&gt; </TT>" sequence instead. Using whitespace to quote text

