Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315751AbSENOzN>; Tue, 14 May 2002 10:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSENOzM>; Tue, 14 May 2002 10:55:12 -0400
Received: from imladris.infradead.org ([194.205.184.45]:53265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315751AbSENOzL>; Tue, 14 May 2002 10:55:11 -0400
Date: Tue, 14 May 2002 15:55:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compat code for old devfs naming scheme
Message-ID: <20020514155508.A31292@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020514125339.A23979@infradead.org> <200205141435.g4EEZ3V07379@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 08:35:03AM -0600, Richard Gooch wrote:
> > As this was never present in official kernels there is really no need
> > in keeping it - it just bloats the kernel.
> > 
> > Could you please forward this patch to Linus and maybe Marcelo with
> > your next devfs update?
> 
> What on earth are you talking about? This code has been in the kernel
> since 2.3.46. It's just lived in a different place: fs/devfs/util.c.
> 

Of course this code was present, otherwise it would be rather hard to
remove it..

But the old devfs naming scheme was obsolete before devfs was merged in
2.3.46 so there is no valid reason to support it for root=.


