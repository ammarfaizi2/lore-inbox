Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWHXGeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWHXGeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWHXGeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:34:37 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:61399 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1030326AbWHXGeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:34:37 -0400
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
From: Dax Kelson <dax@gurulabs.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Theodore Bullock <tbullock@nortel.com>, robm@fastmail.fm,
       brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1156392717.26289.44.camel@mulgrave.il.steeleye.com>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
	 <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
	 <1156375551.4306.10.camel@mentorng.gurulabs.com>
	 <1156392717.26289.44.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 00:34:34 -0600
Message-Id: <1156401274.4256.53.camel@thud.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 23:11 -0500, James Bottomley wrote:
> On Wed, 2006-08-23 at 17:25 -0600, Dax Kelson wrote:
> > It would be great if the arcmsr driver could be included in 2.6.18 so it
> > can make into all the new distro releases that will be happening the
> > last 3-4 months of the year.
> > 
> > It is completely self contained and it isn't changing any existing code
> > (ergo it can't break anything) so I believe there is quite a bit of
> > precedence for "late" inclusion in 2.6.18?

> There's precedent for putting relatively uncontroversial drivers into
> the -rc tree.  

Indeed, this precedent goes back many years.

> However, arcmsr has had a rather difficult path into the
> kernel.  Moving it into scsi-misc is a signal that it goes from being
> out of tree to in-tree candidate (i.e. I'm happy with the quality now,
> but I'll give other people a chance to voice concerns), but on a slow
> path that allows people time to find problems and fix them.  This path
> also dictates a time line for any final objections arising (i.e. up
> until 2.6.18 is declared).

People have been using the driver out of tree (with all the pain that
out of tree drivers entail) for almost 2 years with few if any problems.
The driver worked OK even before it got whipped into submission shape.

Another data point supporting the stability and well tested nature of
the driver is that a widely used distro has been shipping it since June,
Ubuntu 6.06 LTS.

Like Greg's OLS keynote aptly covered, the Linux hardware model is
geared towards and encourages in-tree drivers. 

In fact, from the keynote "... We have a whole sub-architecture that
only has 2 users in the world out there. We have drivers that I know
have only one user, as there was only one piece of hardware ever made
for it. It just isn't true, we will take drivers for anything into our
tree, as we really want it."

Areca hardware owners have been experiencing the out-of-tree pain for a
long time. James is happy with the quality, it is a new driver, well
tested, has been shipped by a major distro. People have had the ample
chance to voice concerns.

Why prolong the pain? Hook a brother up already.

Dax Kelson

