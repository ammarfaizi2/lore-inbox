Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315780AbSENPdx>; Tue, 14 May 2002 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSENPdw>; Tue, 14 May 2002 11:33:52 -0400
Received: from imladris.infradead.org ([194.205.184.45]:50450 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315780AbSENPdv>; Tue, 14 May 2002 11:33:51 -0400
Date: Tue, 14 May 2002 16:33:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compat code for old devfs naming scheme
Message-ID: <20020514163347.A5474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020514125339.A23979@infradead.org> <200205141435.g4EEZ3V07379@vindaloo.ras.ucalgary.ca> <20020514155508.A31292@infradead.org> <200205141459.g4EExfU07828@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 08:59:41AM -0600, Richard Gooch wrote:
> The reason to support it is because lots of people are depending on
> it. A lot of systems would break for no real gain. This code is in the
> init section, so the memory will be freed before init(8) starts.
> 
> The code should stay. In 2.5, I can move it into the mini devfsd that
> will go into the initial rootfs.

Exactly how many system exist which

  a) still use the two or three year old devfs naming scheme for
     their root= command line
  b) use current 2.5 kernels

and

  c) have users not capable of translating that syntax to either
     the new devfs or traditional Linux syntax?

I don't think there are more then about ten, and no I _absolutely_
do not consider that a reason to bloat the kernel, even if it is just
source and image bloat.

