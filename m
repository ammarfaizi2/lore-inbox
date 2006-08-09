Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWHIWpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWHIWpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHIWpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:45:43 -0400
Received: from mail.suse.de ([195.135.220.2]:24732 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751417AbWHIWpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:45:42 -0400
Date: Wed, 9 Aug 2006 15:45:27 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
Message-ID: <20060809224527.GB17840@kroah.com>
References: <20060809062514.GA27491@havoc.gtf.org> <20060809184749.GA12941@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809184749.GA12941@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:47:49AM -0700, Greg KH wrote:
> On Wed, Aug 09, 2006 at 02:25:14AM -0400, Jeff Garzik wrote:
> > 
> > Please pull from 'upstream-greg' branch of
> > master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg
> 
> Applied, thanks.
> 
> Hm, should these fixes solve my SATA cdrom driver timeout issue?  I'll
> go test that, it was still broken in 2.6.18-rc4...

Nope, still get the same timeout error at boot time.  This works just
fine with 2.6.17, and I reported it a while ago.  Any ideas of things I
can do to work on this getting fixed?

2.6.18 shouldn't go out with this broken, imo.

thanks,

greg k-h
