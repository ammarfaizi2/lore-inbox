Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266361AbUGAW4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUGAW4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUGAW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:56:34 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:40895 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266337AbUGAW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:56:16 -0400
Date: Fri, 2 Jul 2004 00:56:13 +0200
From: bert hubert <ahu@ds9a.nl>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Mikael.Pettersson@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: perfctr questions
Message-ID: <20040701225613.GA21173@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Bryan O'Sullivan <bos@serpentine.com>, Mikael.Pettersson@csd.uu.se,
	linux-kernel@vger.kernel.org
References: <20040701220448.GA16515@outpost.ds9a.nl> <1088720394.32000.26.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088720394.32000.26.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

Thanks for your quick reply!

On Thu, Jul 01, 2004 at 03:19:54PM -0700, Bryan O'Sullivan wrote:

> called papiex that provides a less intimidating performance counter
> interface.  However, building PAPI with a not-quite-the-same version of
> perfctr is a bit daunting, so I don't recommend that, either.

pepiex doesn't build for me, I was actually trying that already. It tries to
take over pthreads, which I think breaks. PAPI does look nice though.

> Your third option is to build a version of perfex that I've hacked on,
> but not had time to finish up and submit to Mikael.  I've attached it as
> a tarball.  This includes a man page that makes the usage less scary,
> and it also accepts (gasp) textual arguments instead of hex strings.
> I've tested it on P6, Pentium M and AMD64 chips.

Ah, cool - seems to have bitrotted somewhat, perfctr_*_event_* appear no
longer to exist in perfctr 2.7.3.

In any case, your manpage inspired some command lines that at least appear
to generate numbers, thanks.

But we're obviously not there yet.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
