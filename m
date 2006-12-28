Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbWL1W6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWL1W6U (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWL1W6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:58:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:49789 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965048AbWL1W6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:58:19 -0500
Date: Thu, 28 Dec 2006 14:57:06 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Castricum <mail0612@bencastricum.nl>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061228225706.GA886@suse.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <20061228223909.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228223909.GK20714@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 11:39:09PM +0100, Adrian Bunk wrote:
> 
> Subject    : PCI_MULTITHREAD_PROBE breakage
> References : http://lkml.org/lkml/2006/12/12/21
> Submitter  : Ben Castricum <mail0612@bencastricum.nl>
> Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
>              commit 009af1ff78bfc30b9a27807dd0207fc32848218a
> Status     : known to break many drivers; revert?

PCI_MULTITHREAD_PROBE is now only able to be enabled if you also enable
CONFIG_BROKEN, so this can be removed from your list.

thanks,

greg k-h
