Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289352AbSBEHvl>; Tue, 5 Feb 2002 02:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289348AbSBEHvb>; Tue, 5 Feb 2002 02:51:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289347AbSBEHvW>;
	Tue, 5 Feb 2002 02:51:22 -0500
Message-ID: <3C5F8EF7.7CEB475E@mandrakesoft.com>
Date: Tue, 05 Feb 2002 02:51:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
In-Reply-To: <200202041324.g14DOcv7001338@tigger.cs.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Jeff Garzik <garzik@havoc.gtf.org> said:
> > On Fri, Feb 01, 2002 at 03:03:13PM +0000, Alan Cox wrote:
> > > > If you have a dependency concern, you put yourself in the
> > > > right initcall group.  You don't depend ever on the order within the
> > > > group, thats the whole idea.  You can't depend on that, so you must
> > > > group things correctly.
> 
> > > This was proposed right back at the start. Linus point blank vetoed it.
> 
> > My ideal would be to express dependencies in driver.conf (when that is
> > implemented), and that will in turn affect the link order by
> > autogenerating part of vmlinux.lds.  Until then, initcall groups are
> > fine with me...
> 
> Not _one_ central file telling everything, please! Let each driver declare
> what it needs and provides, and sort it out from there.

"driver.conf" is a reference is a metadata file per driver or
per-subdirectory, not one big file.

Linus suggested this back in December.  See the links I posted.


> Why do I have this uneasy feeling it would somehow overlap with CML2's job?

It could either (a) generate CML2 or (b) make CML2 irrelevant, depending
on the implementation.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
