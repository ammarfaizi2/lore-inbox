Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUCVTBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUCVTBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:01:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:56960 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262257AbUCVTAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:00:48 -0500
Date: Mon, 22 Mar 2004 09:59:50 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, gerg@snapgear.com
Subject: Re: [PATCH 2.6 stallion.c] RFT added class support to stallion.c
Message-ID: <20040322175950.GB15994@kroah.com>
References: <68680000.1079748527@w-hlinder.beaverton.ibm.com> <20040321131410.A7758@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321131410.A7758@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 01:14:10PM +0000, Christoph Hellwig wrote:
> On Fri, Mar 19, 2004 at 06:08:47PM -0800, Hanna Linder wrote:
> > 
> > Here is a patch to add class support to the Stallion multiport 
> > serial driver.
> > 
> > I have verified it compiles but do not have the hardware. 
> > If you can please verify, thanks.
> > 
> > Please consider for Inclusion or Testing.
> 
> Shouldn't this be covered by the tty subsystem?

Seems that this driver also has a character device that it uses for some
non-tty like things :(

So yes, the main tty interface is already covered by the tty subsystem,
but this patch is still needed for full coverage of this driver.

thanks,

greg k-h
