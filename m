Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVLCW2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVLCW2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLCW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:28:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:25475 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751301AbVLCW2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:28:01 -0500
Date: Sat, 3 Dec 2005 14:27:49 -0800
From: Greg KH <greg@kroah.com>
To: Otavio Salvador <otavio@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] OSS: replace all uses of pci_module_init with pci_register_driver
Message-ID: <20051203222749.GA2863@kroah.com>
References: <11336254302237-git-send-email-otavio@debian.org> <20051203205627.GB4573@kroah.com> <873bl93mrh.fsf@nurf.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bl93mrh.fsf@nurf.casa>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 07:15:46PM -0200, Otavio Salvador wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Sat, Dec 03, 2005 at 01:57:10PM -0200, Otavio Salvador wrote:
> >> This patch replace all calls to pci_module_init, that's deprecated and
> >> will be removed in future, with pci_register_driver that should be
> >> the used function now.
> >
> > Sorry, but Richard Knutsson <ricknu-0@student.ltu.se> already did all of
> > this last week.  His patches are in the latest -mm release, and are in
> > my queue too.
> 
> No problem. He did it on all source or just oss subsystem?

Look at the archives to be sure, but I'm pretty sure he did the whole
kernel tree.

thanks,

greg k-h
