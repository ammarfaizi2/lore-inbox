Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbTCFWPS>; Thu, 6 Mar 2003 17:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbTCFWPR>; Thu, 6 Mar 2003 17:15:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46084 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268432AbTCFWPQ>; Thu, 6 Mar 2003 17:15:16 -0500
Date: Thu, 6 Mar 2003 22:25:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030306222546.K838@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306221136.GB26732@gtf.org>; from jgarzik@pobox.com on Thu, Mar 06, 2003 at 05:11:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 05:11:36PM -0500, Jeff Garzik wrote:
> On Thu, Mar 06, 2003 at 10:34:16PM +0000, Alan Cox wrote:
> > On Thu, 2003-03-06 at 21:10, Robin Holt wrote:
> > > The patch at the end of this email makes ipconfig.c work as a loadable 
> > > module under the 2.5.  The diff was taken against the bitkeeper tree 
> > > changeset 1.1075.
> > 
> > The right fix is to delete ipconfig.c, it has been the right fix for a long
> > long time. There are initrd based bootp/dhcp setups that can also then mount
> > a root NFS partition and they do *not* need any kernel helper.
> 
> The klibc tarball on kernel.org also has ipconfig-type code, waiting for
> initramfs early userspace :)
> 
> Many have wanted to delete ipconfig.c for a while now...

Yep, can't the deletion wait a couple more weeks or so until klibc gets
merged?  It's not like ipconfig.c is broken currently, is it?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

