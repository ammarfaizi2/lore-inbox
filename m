Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWHCHVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWHCHVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWHCHVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:21:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54754 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932357AbWHCHVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:21:12 -0400
Date: Thu, 3 Aug 2006 00:16:34 -0700
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>, stable@kernel.org,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH 2.6.18-rc3, 2.6.17.7] ieee1394: sbp2: enable auto spin-up for Maxtor disks
Message-ID: <20060803071634.GK26354@kroah.com>
References: <tkrat.f5b216d7ca35e7f2@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.f5b216d7ca35e7f2@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 07:40:06PM +0200, Stefan Richter wrote:
> At least Maxtor OneTouch III require a "start stop unit" command after
> auto spin-down before the next access can proceed.  This patch activates
> the responsible code in scsi_mod for all Maxtor SBP-2 disks.
> https://bugzilla.novell.com/show_bug.cgi?id=183011
> 
> Maybe that should be done for all SBP-2 disks, but better be cautious.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Queued to -stable.

thanks,

greg k-h

