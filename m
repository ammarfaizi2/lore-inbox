Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWIVHFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWIVHFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIVHFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:05:37 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:13020 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1750817AbWIVHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:05:37 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200609220723.k8M7N1Vp021675@auster.physics.adelaide.edu.au>
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Fri, 22 Sep 2006 16:53:01 +0930 (CST)
Cc: akpm@osdl.org (Andrew Morton),
       jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1158908381.10415.1.camel@imp.csi.cam.ac.uk> from "Anton Altaparmakov" at Sep 22, 2006 07:59:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > We have a machine which is currently making heavy use of a usb hard disc
> > > > > formatted with ntfs.  There have been two occasions where the kernel has
> > > > > oopsed while this disc was being accessed heavily.  Before adding this HDD
> > > > > the machine in question was rock solid which leads me to think that it
> > > > > might be related to ntfs.  USB drives formatted with other filesystems do
> > > > > not appear to suffer from this problem.
> > > 
> > > I have now seen such an oops too with 2.6.18 kernel.
> > 
> > I assume it is a once-off?
> 
> So far yes.  I now have seen a recursive locking thing reported by the
> new lock analyzer but that looks like it has to do with NFS (my home
> directory is on NFS) so I don't think it is in any way related.

Our setup also has user home directories on NFS, so that much at least is
common to our configurations.  I don't know if the USB/NTFS user was writing
to their home directory as part of their work at the time of the oops
though.

Regards
  jonathan
