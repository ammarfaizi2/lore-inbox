Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbRLUTUm>; Fri, 21 Dec 2001 14:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285036AbRLUTUd>; Fri, 21 Dec 2001 14:20:33 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:46861 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285020AbRLUTP3>;
	Fri, 21 Dec 2001 14:15:29 -0500
Date: Tue, 18 Dec 2001 00:17:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: User-manageable sub-ids proposals
Message-ID: <20011218001702.A37@toy.ucw.cz>
In-Reply-To: <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es> <20011213143752.A17124@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011213143752.A17124@vestdata.no>; from kernel@ragnark.vestdata.no on Thu, Dec 13, 2001 at 02:37:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And we end up with a different solution:
> olduid=getuid();
> /* Allocate a uid with no privilegies */

Dangerous. Imagine:

	while (1) {
