Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271165AbRIGFMo>; Fri, 7 Sep 2001 01:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271182AbRIGFMf>; Fri, 7 Sep 2001 01:12:35 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24588 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271165AbRIGFMU>; Fri, 7 Sep 2001 01:12:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>, Christoph Lameter <christoph@lameter.com>
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other patches
Date: Fri, 7 Sep 2001 07:19:31 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office> <999837964.865.3.camel@phantasy>
In-Reply-To: <999837964.865.3.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907051231Z16200-26183+114@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 7, 2001 06:45 am, Robert Love wrote:
> On Fri, 2001-09-07 at 00:36, Christoph Lameter wrote:
> > Given the minimal nature of the patch I would suggest that it become part
> > of 2.4.10 or 11
> 
> Are you kidding?  We will be lucky to see this in during 2.5.
> Its a pretty big change.  It makes the Linux kernel preemptible.

CONFIG_PREEMPT

> This is a fairly big move, one I don't think any of the major Unices have
> done.

The other Unices are at least evenly split, or mostly preemptible.
Typically, a more complex strategy is used where spinlocks can sleep
after a few spins.  This patch is very conservative in that regard,
it basically just uses the structure we already have, SMP spinlocks.

> The only reason the patch is not _huge_ is because the Linux
> kernel is already setup for concurrency of this nature -- it does SMP.
> 
> I suggest you read
> http://www.linuxdevices.com/articles/AT4185744181.html
> http://www.linuxdevices.com/articles/AT5152980814.html
> http://kpreempt.sourceforge.net
> 
> and my previous threads on this issue, for more informaiton.

Hmm, how did you read those and come to such a different conclusion?

--
Daniel
