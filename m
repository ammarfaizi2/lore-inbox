Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTD3SEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTD3SEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:04:08 -0400
Received: from ns.suse.de ([213.95.15.193]:36868 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262284AbTD3SEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:04:05 -0400
Date: Wed, 30 Apr 2003 20:15:17 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030430181517.GA22761@Wotan.suse.de>
References: <20030429155731.07811707.akpm@digeo.com.suse.lists.linux.kernel> <p73r87k3gx9.fsf@oldwotan.suse.de> <20030430180922.GB453@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430180922.GB453@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 08:09:22PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Generic item: 
> > 
> > - need to share the ioctl 32bit emulation handlers between ports. 
> > Pavel has a patch, but he's running into difficulties with merging it.
> 
> Its in now.

Yes and nothing compiles anymore because linux/compat_ioctl.h is missing.

And really the table merge is not enough - all the functions need to 
be shared too.

-Andi
