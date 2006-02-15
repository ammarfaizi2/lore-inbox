Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWBODSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWBODSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWBODSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:18:11 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:8165 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030610AbWBODSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:18:10 -0500
From: Rob Landley <rob@landley.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 22:18:03 -0500
User-Agent: KMail/1.8.3
Cc: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141924.22965.rob@landley.net> <20060215005439.GB18326@kroah.com>
In-Reply-To: <20060215005439.GB18326@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602142218.04158.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 7:54 pm, Greg KH wrote:
> On Tue, Feb 14, 2006 at 07:24:22PM -0500, Rob Landley wrote:
> > I plan to start objecting earlier in future next time they propose to
> > break us for no readily apparent reason.
>
> Please do.

I will.  I'm not complaining to you about failure to provide timely feedback.  
(I fell behind on the list again...)

> That was because we needed a local copy of libsysfs due to linking
> against klibc.  Also because we needed to fix up libsysfs to actually
> work for our needs :)
>
> Anyway, we've now dropped libsysfs entirely, replacing it with 200 lines
> of code that is much faster and more flexible.

Yup.

> libsysfs dried up and blew away when IBM abandonded it and stoped
> funding the developers who were working on it.  Projects need active
> developers, something that IBM was not willing to provide for this one,
> for whatever reason...

I'm still not sure why it existed in the first place.  Oh well.

> > If mdev accomplishes nothing else, we can poke Linus and go "no fair,
> > this was exported to userspace and we depend on it", which udev hasn't.
>
> Again, please complain if we break anything, we want to know, and I'll
> do my best to keep it from happening.

Understood.  I'm caught up with the list again (ok, I skipped 3 months) and am 
going to try to stay that way...

> thanks,
>
> greg k-h

Rob
-- 
Never bet against the cheap plastic solution.
