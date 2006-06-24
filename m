Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752232AbWFXNQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbWFXNQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWFXNQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:16:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:39047 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752230AbWFXNQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:16:24 -0400
Date: Sat, 24 Jun 2006 09:15:55 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 64bit resources start end value fix
Message-ID: <20060624131555.GB980@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060621172903.GC9423@in.ibm.com> <20060624024513.GB29637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624024513.GB29637@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 07:45:13PM -0700, Greg KH wrote:
> On Wed, Jun 21, 2006 at 01:29:03PM -0400, Vivek Goyal wrote:
> > Hi Greg,
> > 
> > While changing 64bit kconfig options to CONFIG_RESOURCES_64BIT, I forgot
> > to update the values of start and end fields in ioport_resource and
> > iomem_resource.
> > 
> > Following patch applies on top of your reworked 64 bit patches and
> > is based on Andrew Morton's patch. Please apply.
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115087406130723&w=2
> 
> Ok, I think I have this finally all straigned out.  Can you look at my
> quilt tree to verify that I've tweaked everything properly based on
> this, and the other cleanup patches you and Andrew have been sending me
> recently?
>

I looked into following tree.

http://kernel.org/git/?p=linux/kernel/git/gregkh/patches.git;a=summary

Everything seems to be fine except that following i2c patch from andrew
seems to be missing.

http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115086650916817&w=2

Thanks
Vivek 
