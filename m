Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282190AbRK2ADn>; Wed, 28 Nov 2001 19:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282204AbRK2ADd>; Wed, 28 Nov 2001 19:03:33 -0500
Received: from gordon.ukservers.net ([217.10.138.217]:59407 "HELO
	gordon.ukservers.net") by vger.kernel.org with SMTP
	id <S282190AbRK2ADW>; Wed, 28 Nov 2001 19:03:22 -0500
Date: Thu, 29 Nov 2001 00:05:09 +0000
From: Mark Hymers <markh@linuxfromscratch.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre1
Message-ID: <20011129000509.A1362@markcomp.blaydon.hymers.org.uk>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E169EIY-0006UI-00@the-village.bc.nu> <1006991294.813.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1006991294.813.0.camel@phantasy>; from rml@tech9.net on Wed, Nov 28, 2001 at 06:48:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28, Nov, 2001 at 06:48:13PM -0500, Robert Love spoke thus..
> On Wed, 2001-11-28 at 18:39, Alan Cox wrote:
> > > use "BSD without advertising clause", which causes the kernel to
> > > be
> > > tainted. Shouldn't fs/nls/*.c use "Dual BSD/GPL" or "GPL" instead?
> >
> > Dual BSD/GPL is the correct one.  Not a big issue. Since the GPL
> > allows
> > stuff to be freer than GPL but still GPL its arguably correct too I
> > suspect
>
> I was waiting for confirmation about the license status...without
> getting into what license is correct and legal, the current
> MODULE_LICENSE value taints the kernel.  The attached patch switches
> to
> Dual BSD/GPL.
Do you know what the legal status of the rest of the *.c files in fs/nls
is?  There are still quite a few which have no MODULE_LICENSE tag at all
which causes the kernel to be tainted (IMO) incorrectly.

Mark

-- 
Mark Hymers					 BLFS Editor
markh@linuxfromscratch.org
