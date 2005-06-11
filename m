Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVFKOmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVFKOmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVFKOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:40:44 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:26476 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261716AbVFKOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:39:10 -0400
Date: Sat, 11 Jun 2005 07:39:04 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611143904.GA30612@suse.de>
References: <20050611074327.GA27785@kroah.com> <20050611102133.GA3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611102133.GA3770@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:21:34PM +0200, Adrian Bunk wrote:
> On Sat, Jun 11, 2005 at 12:43:27AM -0700, Greg KH wrote:
> >...
> > Comments welcome.
> >...
> 
> Please don't remove the !CONFIG_DEVFS_FS dummies from devfs_fs_kernel.h.
> 
> I'm sure some driver maintainers will want to keep the functions in 
> their code because they share their drivers between 2.4 and 2.6 .

All drivers should be in the mainline kernel tree, so why would they
need this?  Remember, out-of-the-tree drivers are on their own...

thanks,

greg k-h
