Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWHNOtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWHNOtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWHNOtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:49:08 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:47287 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751890AbWHNOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:49:07 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Erik Slagter <erik@slagter.name>
Subject: Re: md mirror / ext3 / dual core performance strange phenomenon?
Date: Mon, 14 Aug 2006 15:48:50 +0100
User-Agent: KMail/1.9.4
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <10837.1155561722@ocs10w.ocs.com.au> <1155561963.7809.30.camel@skylla.slagter.name>
In-Reply-To: <1155561963.7809.30.camel@skylla.slagter.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141548.51047.s0348365@sms.ed.ac.uk>
X-Originating-Pythagoras-IP: [217.155.137.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 14:26, Erik Slagter wrote:
> On ma, 2006-08-14 at 23:22 +1000, Keith Owens wrote:
> > >BUT... starting from -j4 (and upwards) the compile time suddenly goes to
> > >3.5 minutes!
> >
> > Nothing to do with the disks, it is a design flaw in the kernel build
> > system.  If you want a useful parallel make using -j<n>, set <n> to 3,
> > 4 or 5 higher than the real number of parallel jobs that you want.  The
> > exact value to add depends on which kernel tree you are building.  See
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115553906404695&w=2
>
> Okay, so it basically means I shouldn't worry here.
>
> Sorry for bothering, I couldn't come up with a proper search term...

I find that for mainline, using an odd number of jobs works better. I can get 
my X2 3800+ to full saturation with -j5.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
