Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269860AbUIDJtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269860AbUIDJtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269859AbUIDJtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:49:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64517 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269860AbUIDJsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:48:47 -0400
Date: Sat, 4 Sep 2004 10:48:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904104834.B13362@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41398EBD.2040900@tungstengraphics.com>; from keith@tungstengraphics.com on Sat, Sep 04, 2004 at 10:45:33AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 10:45:33AM +0100, Keith Whitwell wrote:
> > Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
> > copy of scsi helpers into each scsi driver either, or libata into each sata
> > driver.
> 
> But regular users don't tend to pull down new scsi or ata drivers in the same 
> way that they do graphics drivers.  Hence the concern of many drm developers 
> to avoid introducing new failure modes in this process.

Actually regulat users do.  And they do by pulling an uptodate kernel or
using a vendor kernel with backports.  This model would work for video drivers
aswell.

> People who'd never dream of upgrading their kernel have acquired the habit of 
> pulling down up-to-date video drivers on a weekly or monthly basis.  So, for 
> sanity's sake, the DRI/DRM has been in the business of minimizing exposed 
> interfaces, and for my money, should continue to be in that business.

And DRM is the most crappy code in the kernel.  See any corelations?

