Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSGLL6w>; Fri, 12 Jul 2002 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGLL6v>; Fri, 12 Jul 2002 07:58:51 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:45835 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S315929AbSGLL6u>; Fri, 12 Jul 2002 07:58:50 -0400
Date: Fri, 12 Jul 2002 05:01:33 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
Message-ID: <20020712120133.GB32601@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship> <003f01c2297e$b3e395d0$1c6fa8c0@hyper> <E17SwAM-0002e2-00@starship> <005801c2298c$9f3f6f10$1c6fa8c0@hyper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005801c2298c$9f3f6f10$1c6fa8c0@hyper>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sniped a back and forth about make bzimage bz2image
bz2bzimage etc.]
On Fri, Jul 12, 2002 at 12:12:18PM +0200, Christian Ludwig wrote:
> Daniel Phillips wrote on Friday, July 12, 2002 10:52 AM:
> 
> > Now that you mention it, bzImage should continue to serve perfectly well,
> > so long as you have some other way of configuring the kernel compression
> > method than via the make target.  Why not just make the compression method
> > a config option?  If it had been done this way from the beginning, we'd
> > never have acquired the b or the z.
> >
> > This way you avoid the entire controversy of chosing a new name for the
> > kernel image, and anyway, it's a nicer interface than via the make
> > target.
> 
> That came into my mind, too. Let's see what I can do about it...
> It won't probably be ready before August, because I still have some exams.

Ditto.  A config option is where this belongs.  The
filename stays the same.  This avoids the issue of
forgetting which compression you are using.  It gets saved
in the config and make install will cover it.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
