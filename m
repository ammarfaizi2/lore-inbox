Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWCOJSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWCOJSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWCOJSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:18:34 -0500
Received: from ns.firmix.at ([62.141.48.66]:14770 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750784AbWCOJSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:18:34 -0500
Subject: Re: [future of drivers?] a proposal for binary drivers.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Valdis.Kletnieks@vt.edu
Cc: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org,
       Jan Knutar <jk-lkml@sci.fi>
In-Reply-To: <200603150050.k2F0ogpT019966@turing-police.cc.vt.edu>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603081151.33349.jk-lkml@sci.fi>
	 <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
	 <1142291208.8407.46.camel@gimli.at.home>
	 <200603150050.k2F0ogpT019966@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 15 Mar 2006 10:18:25 +0100
Message-Id: <1142414305.4073.132.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 19:50 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 14 Mar 2006 00:06:48 +0100, Bernd Petrovitsch said:
> > On Wed, 2006-03-08 at 15:33 +0530, Anshuman Gholap wrote:
> > [...]
> > > into installing it) , he knowing me as a linux person will keep
> > > bugging me, when i tell him to install a kernel source compile it to
> > > allow 16k stack, install ndiswrapper and load the windows driver and
> > 
> > And you seriously think that $COMPANY will rewrite their driver to work
> > with 4K-stacks (which seems to me to be an absolute requirement ATM)?
> 
> From the NVidia drivers changelog:

NVidia is one of the better examples (and I leave the binary driver
discusion out) - they supported their drivers from the start (and the
first years there were lots of trouble with official builds every other
day or so IIRC).

[...]
> Looks like they managed to do that quite some time ago - in fact, before
> some parts of the *in-kernel* code were totally cleaned up....
> 
> So yes, I *do* expect $COMPANY to re-write their driver to support 4K stacks. ;)

Of course implies "maintaing a driver for Linux" that such
maintenance/development/call-it-what-you-want is done (and not only for
4K-stacks - this just a current example and probably needs handling on
the driver side and providing some "compatibility layer" won't work that
good).

My doubt is that (above supposed old-economy) $COMPANY (which was more
or less "forced" to support Linux and didn't "freely" choose that way
like NVidia) writes a driver (or payed someone external once for it) and
considers the "Linux case" closed for the next 3 years (as you would
with a Win*-driver).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

