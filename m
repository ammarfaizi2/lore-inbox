Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTFVXAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTFVXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:00:53 -0400
Received: from granite.he.net ([216.218.226.66]:52996 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263633AbTFVXAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:00:52 -0400
Date: Sun, 22 Jun 2003 15:53:52 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Goddard <agoddard@purdue.edu>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.73
Message-ID: <20030622225352.GA3319@kroah.com>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <Pine.LNX.4.56.0306221453010.1455@dust> <20030622131526.0dbb39d0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622131526.0dbb39d0.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 01:15:26PM -0700, Andrew Morton wrote:
> Alex Goddard <agoddard@purdue.edu> wrote:
> >
> > drivers/usb/host/ehci-hcd.c:977: error: pci_ids causes a section type 
> > conflict
> 
> 
> Yup.
> 
> __devinitdata declarations should not be marked const.

Did anyone ever figure out why this is true?

greg k-h
