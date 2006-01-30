Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWA3T6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWA3T6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWA3T6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:58:42 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:61105 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S964931AbWA3T6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:58:42 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Doug Thompson <norsk5@yahoo.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@redhat.com>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 11:58:09 -0800
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
In-Reply-To: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301158.09438.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 10:59, Doug Thompson wrote:
> that driver should be refactored to only output NON-FATALs with debug
> turned on.

I would prefer a sysfs option or something similar that allows the user
to determine what action to take on these errors.  I think the debug
option should only pertain to messages whose purpose is for debugging
the EDAC code itself, as opposed to hardware errors detected by EDAC.

> Copying to edac/bluesmoke mailing list
>
> doug t
>
> --- Dave Jones <davej@redhat.com> wrote:
> > On Sun, Jan 29, 2006 at 04:52:06PM -0500, Alan Cox wrote:
> >  > On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
> >  > > e752x_edac is very noisy on my PCIE system..
> >  > > my dmesg is filled with these...
> >  > >
> >  > > [91671.488379] Non-Fatal Error PCI Express B
> >  > > [91671.492468] Non-Fatal Error PCI Express B
> >  > > [91901.100576] Non-Fatal Error PCI Express B
> >  > > [91901.104675] Non-Fatal Error PCI Express B
> >  >
> >  > Pre-production system or final release ?
> >
> > Currently shipping Dell Precision 470.
> >
> > 		Dave
