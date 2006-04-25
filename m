Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWDYFPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWDYFPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWDYFPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:15:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:15257 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751391AbWDYFPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:15:50 -0400
Date: Mon, 24 Apr 2006 22:08:20 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] kref debugging config option
Message-ID: <20060425050820.GA23373@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083342.069630000@localhost.localdomain> <20060424143845.39412304.akpm@osdl.org> <20060425045337.GB5698@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425045337.GB5698@miraclelinux.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:53:37PM +0800, Akinobu Mita wrote:
> On Mon, Apr 24, 2006 at 02:38:45PM -0700, Andrew Morton wrote:
> > Akinobu Mita <mita@miraclelinux.com> wrote:
> > >
> > > This patch converts all WARN_ON() in kref code to BUG_ON().
> > 
> > Why?  This change will irritate testers and will decrease their ability to
> > capture (and hence report) diagnostic info.
> 
> I have no grudge against this BUG_ON().
> 
> But BUG_ON() is more prominent than WARN_ON().

Sure, it crashes your kernel, hopefully you notice that better :)

thanks,

greg k-h
