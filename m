Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWFFU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFFU4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWFFU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:56:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45526 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751079AbWFFU4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:56:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Tue, 6 Jun 2006 22:56:55 +0200
User-Agent: KMail/1.9.3
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <448366FB.1070407@zytor.com> <20060606152041.GA5427@ucw.cz>
In-Reply-To: <20060606152041.GA5427@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606062256.55472.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 06 June 2006 17:20, Pavel Machek wrote:
> > >git-klibc.patch
> > >
> > > Similar.  This all appears to work sufficiently well 
> > > for a 2.6.18 merge. But it's been so long since klibc 
> > > was a hot topic that I've forgotten who
> > > wanted it, and what for.
> > >
> > > Can whoever has an interest in this work please pipe 
> > > up and let's get our
> > > direction sorted out quickly.
> > >
> > 
> > klibc (early userspace) in its current form is 
> > fundamentally a cleanup. What it does is unload code 
> >  from the kernel which has no fundamental reason to be 
> > kernel code (written during kernel rules, with all the 
> > problems it entails.)  The initial code to have removed 
> > is the root-mounting code, with all the various ugly 
> > mutations of that (ramdisk loading, NFS root, initrd...)
> > 
> > The original idea was due Al Viro; obviously, the 
> > implementation is mostly mine.
> > 
> > It is of course my hope that this will be used for more 
> > than just plain initialization code, but that in itself 
> > is a significant step, and one has to start somewhere.
> 
> It allows me to unify swsusp & uswsusp into one in future, for
> example, reducing code duplication.

[cough] How distant is the future you're referring to?

Rafael
