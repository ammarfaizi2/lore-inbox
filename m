Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSH0VXX>; Tue, 27 Aug 2002 17:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSH0VXX>; Tue, 27 Aug 2002 17:23:23 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:28679 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317385AbSH0VXW>; Tue, 27 Aug 2002 17:23:22 -0400
Date: Tue, 27 Aug 2002 22:27:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] XFree v4.2.x DRM/DRI Support for 2.4.20-pre4
Message-ID: <20020827222740.A6591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200208272247.26637.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208272247.26637.m.c.p@gmx.net>; from m.c.p@wolk-project.de on Tue, Aug 27, 2002 at 10:54:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 10:54:50PM +0200, Marc-Christian Petersen wrote:
> Hi there,
> 
> this adds DRM/DRI Support for recent versions of XFree, f.e. v4.2.0 with a 
> slight modification. If you select SiS DRM Module, you also have to select 
> FrameBuffer SiS support otherwise it will result in unresolved symbols or 
> linking failure.

Don't do this.   Alan already has a sane version in his tree which I've made
ready for and sent to Marcelo.  It wouldn't hurt if you read lkml..

The patch you posted is the crap directly from the XFfree repo and backs out
kernel changes.  It might be enough for a random collection of junk patches
but certainly does not meet the quality criteria for official kernels.
