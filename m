Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVKSFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKSFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 00:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKSFG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 00:06:28 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:937 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750913AbVKSFG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 00:06:27 -0500
Date: Sat, 19 Nov 2005 06:06:10 +0100
From: Voluspa <lista1@telia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, kjarvel@home.se,
       howarth@bromo.msbb.uc.edu
Subject: Re: PCI error on x86_64 2.6.13 kernel
Message-Id: <20051119060610.08515fa7.lista1@telia.com>
In-Reply-To: <20051119011840.GB28175@kroah.com>
References: <20051118080440.4aaf4a6d.lista1@telia.com>
	<20051119011840.GB28175@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005 17:18:40 -0800 Greg KH wrote:
> On Fri, Nov 18, 2005 at 08:04:40AM +0100, Voluspa wrote:
> > 
> > On 2005-11-18 0:24:51 Rajesh Shah wrote:
> > >On Wed, Oct 26, 2005 at 11:06:05PM +0200, Niklas Kallman wrote:
> > >>Jack Howarth wrote:
> > >>> Has anyone reported the following? For both of the 2.6.13 based
> > >>> kernels released so far on Fedora Core 4 for x86_64, we are seeing
> > >>> error messages of the form...
> > >>> 
> > >>> Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
> > >>> Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
> > >>> Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 \
> > >>> f0000000 for 0000:09:00.0 
> > >
> > >I ran into a similar problem, and posted a fix, see
> > >http://marc.theaimsgroup.com/?l=linux-pci&m=113225006603745&w=2
> > >
> > >Can you try it to see if this problem goes away?
> > 
> > Even though your patch touched arch/i386/pci/i386.c I tried it in my pure AMD64
> > environment. No luck... I remember when this PCI error turned up, but since it
> > was non-fatal I shrugged it off. Early 2.6.13 it was. Booting back on my
> > non-distro, plain kernel.org notebook I indeed see that 2.6.11.11 and 2.6.12
> > are fine.
> 
> Others are reporting this problem too.
> 
> Is there any way you could be able to run 'git bisect' between 2.6.12
> and 2.6.13 to try to find the offending changeset?  I would really
> appreciate it.

I have to do all the groundwork first (getting git, some dataset, read an howto),
but I'll try to return with some answers by weekend's end or Monday morning. If I fail,
the pointer will be the oldfashioned -rcX is Ok but -rcY not.

Mvh
Mats Johannesson
--
