Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTJZXMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTJZXMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 18:12:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61431 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263155AbTJZXMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 18:12:49 -0500
Date: Sun, 26 Oct 2003 14:03:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Blockbusting news, results get worse
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB39B@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.10.10310261400580.14405-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric,

Item "3" in your list is not practical, because no drive maker allows the
same drives that large oem's purchase to be placed in retail.  There are
obvious reasons, but your position stated for the average joe consumer is
flawed.

Why don't you guys offer extended warrenty purchase service contracts?

DCO the dog out of the replacements and be done.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Sun, 26 Oct 2003, Mudama, Eric wrote:

> 
> 
> > -----Original Message-----
> > From: Norman Diamond [mailto:ndiamond@wta.att.ne.jp]
> >
> > 
> > 4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
> > But it lies.  Subsequent attempts to read still fail.  
> > Subsequent writing of
> > zeroes appears to succeed again.  Subsequent attempts to read 
> > still fail.
> 
> *That* is the fundamental problem with the drive.  If it knows it has had
> trouble with that block in the past, and it gets a new write, it should know
> that is a troublesome area and verify that it was able to put the new block
> in the old location.
> 
> If it can verify that, then there's no need to reallocate it at all, since
> the write most likely cured whatever was wrong.
> 
> If it can't verify it, then it should need to reallocate and verify at the
> new location.
> 
> > They said that they warranty Toshiba disk drives for 1 year.  So
> > if a customer buys a Toshiba disk drive with firmware that 
> > was defective on the day of purchase and defective on the dates
> > of design and manufacture, but if the customer doesn't detect
> > the defective firmware until 366 days later, the customer still
> > gets shafted.
> 
> In theory, I don't see the problem with this.
> 
> It isn't realistic for a vendor to warranty a product forever, and this is
> why OEMs do large qualifications on drives themselves before they purchase a
> single unit, since they know they'll bear the brunt of the support headache
> if the product fails.
> 
> That being said, there are three options:
> 
> 1. Pay a premium for longer warranty.  I know this is available in both IDE
> and SCSI, not sure if it is available in notebook drives.
> 
> 2. Do qualification tests yourself during the first year of operation.
> Hi/low temperature/humidity/air pressure, random command generator, and make
> sure the drive never miscompares or has a hard error it can't "fix".
> (Writing a zero and reading non-zero is a miscompare)
> 
> 3. Look at what products are being shipped in large volume from OEMs, and
> buy the same product yourself.  Dell or HP or IBM can't afford to ship
> products that don't have the lowest in-the-field failure rates, so buying
> what they buy would make sense since they'll run their own tests like #2.
> 
> 
> --eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

