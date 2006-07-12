Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWGLQ71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWGLQ71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGLQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:59:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6807 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751271AbWGLQ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:59:26 -0400
Subject: Re: [klibc] klibc and what's the next step?
From: Arjan van de Ven <arjan@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>,
       klibc@zytor.com, Jeff Garzik <jeff@garzik.org>,
       Roman Zippel <zippel@linux-m68k.org>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060712165423.GA25071@suse.de>
References: <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com>
	 <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
	 <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com>
	 <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com>
	 <20060711200640.GA17653@suse.de> <20060711212232.GA32698@kroah.com>
	 <20060712165423.GA25071@suse.de>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 18:58:38 +0200
Message-Id: <1152723518.3217.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 18:54 +0200, Olaf Hering wrote:
>  On Tue, Jul 11, Greg KH wrote:
> 
> > On Tue, Jul 11, 2006 at 10:06:40PM +0200, Olaf Hering wrote:
> > > And to give a negative example for great regression test opportunities:
> > > You guessed it, SLES10 has a udev that cant handle kernels before 2.6.15.
> > > Great job. I could slap them all day...
> > 
> > Just to be specific, the udev in SLES10 can handle older kernels than
> > 2.6.15 just fine, it's just the boot scripts around it are not written
> > to do so.
> 
> What difference does that make exactly? "It doesnt work."
> -

who cares?

You're talking about compatibility in the wrong direction. You don't
expect to be able to run a 2.2 kernel on SLES10 either. A distro
expecting the kernel to be at least of the version that comes with it
imo is entirely justified and even required to use new features in an
integrated way without overbloating the distro with never used and
undertested compatibility junk.

Running a NEWER kernel.. that's where people have a point.
Now, arguably some of the enterprise distros are not designed with that
in mind (unlike most community distributions), but it's not entirely
unreasonable to expect to be able to do this at least for a while.

Greetings,
   Arjan van de Ven

