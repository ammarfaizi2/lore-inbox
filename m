Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWBXPyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWBXPyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBXPyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:54:03 -0500
Received: from xenotime.net ([66.160.160.81]:31168 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932272AbWBXPyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:54:01 -0500
Date: Fri, 24 Feb 2006 07:53:57 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, dilinger@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 stack trace cleanup
In-Reply-To: <20060224051303.64ff912b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602240753290.7894@shark.he.net>
References: <1140777679.5073.17.camel@localhost.localdomain>
 <200602241147.03041.ak@suse.de> <20060224045044.07fc5921.akpm@osdl.org>
 <200602241400.42432.ak@suse.de> <20060224051303.64ff912b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Andrew Morton wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> > On Friday 24 February 2006 13:50, Andrew Morton wrote:
> > > Andi Kleen <ak@suse.de> wrote:
> > > >
> > > > I can offer you a deal though: if you fix VGA scrollback to have
> > > >  at least 1000 lines by default we can change the oops formatting too.
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/vgacon-add-support-for-soft-scrollback.patch
> >
> > Once that is in and works we can consider changing the oopses.
> >
>
> I don't think we should change the oops format.
>
> Apart from no longer printing a hex-base+decimal-offset, which is braindead.

strongly agree with the hex/decimal braindead part.

> > > Problem is, scrollback doesn't work after panic().  I don't know why..
> >
> > Someone claimed it was related to the panic keyboard blinking.
> >
>
> Strange.  It looks pretty harmless.

-- 
~Randy
