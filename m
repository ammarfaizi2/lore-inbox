Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUHCAvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUHCAvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUHCAvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:51:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:46309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264850AbUHCAsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:48:06 -0400
Date: Mon, 2 Aug 2004 17:44:29 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 1 of 5
Message-ID: <20040803004429.GD26323@kroah.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101350.GC4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101350.GC4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:43:52PM +0530, Ravikiran G Thirumalai wrote:
> Here's the first patch.  This patch 'shrinks' struct kref by removing
> the release pointer in the struct kref.  GregKH has applied this to his tree

I applied a tweaked version of this.  It's now in the bk-drivers tree.

thanks,

greg k-h
