Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUEKVe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUEKVe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUEKVe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:34:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:16297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263711AbUEKVbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:31:52 -0400
Date: Tue, 11 May 2004 14:30:56 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org, jb@technologeek.org
Subject: Re: [PATCH 2.6.6-rc3] Add class support to drivers/usb/misc/tiglusb.c
Message-ID: <20040511213056.GB24789@kroah.com>
References: <79660000.1083267538@dyn318071bld.beaverton.ibm.com> <20040502064915.GF3766@kroah.com> <36460000.1083795831@dyn318071bld.beaverton.ibm.com> <20040505223510.GA30309@kroah.com> <38560000.1083800158@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38560000.1083800158@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 04:35:58PM -0700, Hanna Linder wrote:
> --On Wednesday, May 05, 2004 03:35:10 PM -0700 Greg KH <greg@kroah.com> wrote:
> > 
> > Ick, don't destroy the whole class.  Not good.
> 
> 3rd times the charm.... Only destroying the class when the module is removed.

Looks good, applied, thanks.

greg k-h
