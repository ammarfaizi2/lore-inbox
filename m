Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUHFPSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUHFPSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHFPSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:18:07 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:29196 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266009AbUHFPQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:16:23 -0400
Date: Fri, 6 Aug 2004 17:17:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Vrabel <dvrabel@arcom.com>, Hollis Blanchard <hollisb@us.ibm.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: cross-depmod?
Message-ID: <20040806151757.GA7331@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	David Vrabel <dvrabel@arcom.com>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <1091742716.28466.27.camel@localhost> <411343F9.1080301@arcom.com> <Pine.GSO.4.58.0408061540200.26252@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408061540200.26252@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 03:45:16PM +0200, Geert Uytterhoeven wrote:
> On Fri, 6 Aug 2004, David Vrabel wrote:
> > Hollis Blanchard wrote:
> > > My problem is that I cross-build my kernels, and 'make rpm' is very
> > > unhappy when it can't use depmod. I know that I can do 'make
> > > DEPMOD=/bin/true rpm', but can't we figure that out automatically?
> >
> > I'd suggest not running depmod when building an RPM but instead run it
> > as part of the RPMs post-installation script.
> 
> I guess Hollis (just like me) is mostly interested in the possible error
> messages of depmod, due to missing exported symbols.

This is fixed in modpost so you actually now get a warning when modpost
is executed.

	Sam
