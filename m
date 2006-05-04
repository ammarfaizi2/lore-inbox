Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWEDQpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWEDQpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWEDQpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:45:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32747 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030243AbWEDQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:45:01 -0400
Date: Thu, 4 May 2006 11:44:46 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, pfg@sgi.com, jeremy@sgi.com, jes@sgi.com
Subject: Re: [PATCH] SGI IOC4: Detect IO card variant
In-Reply-To: <20060503192626.1bc3af56.akpm@osdl.org>
Message-ID: <20060504114135.T84279@chenjesu.americas.sgi.com>
References: <20060503171758.H59683@chenjesu.americas.sgi.com>
 <20060503192626.1bc3af56.akpm@osdl.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Andrew Morton wrote:

> On Wed, 3 May 2006 17:21:23 -0500 (CDT)
> Brent Casavant <bcasavan@sgi.com> wrote:
> 
> > +#ifndef PCI_DEVICE_ID_QLOGIC_ISP12160
> > +#define PCI_DEVICE_ID_QLOGIC_ISP12160 0x1216
> > +#endif
> > +#ifndef PCI_VENDOR_ID_VITESSE
> > +#define PCI_VENDOR_ID_VITESSE 0x1725
> > +#endif
> > +#ifndef PCI_DEVICE_ID_VITESSE_7174
> > +#define PCI_DEVICE_ID_VITESSE_7174 0x7174
> > +#endif
> 
> We shouldn't need the ifdefs here.  Let's just get the right defines in the
> right place and use them.

I'll submit a patch for this today.

> I'm unable to work out whether this problem which this patch fixes warrants
> a 2.6.17 merge.

Not really, as the new IO9-RT card which what the patch is primarily for
isn't shipping yet.  If it's in -mm, then I think SGI will be able to get
our distribution partner to pick it up, which is honestly 90% of my
concern at this point.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
