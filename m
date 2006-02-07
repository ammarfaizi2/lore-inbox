Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWBGXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWBGXSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWBGXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:18:21 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4825 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030246AbWBGXSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:18:20 -0500
Date: Tue, 7 Feb 2006 15:18:35 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neal Becker <ndbecker2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060207231835.GA19648@kroah.com>
References: <ds7cu3$9c0$1@sea.gmane.org> <ds7f17$gp7$1@sea.gmane.org> <20060207145913.714fec1c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207145913.714fec1c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
> Neal Becker <ndbecker2@gmail.com> wrote:
> >
> > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
> > 
> > Neal Becker wrote:
> > 
> > > HP dv8000 notebook
> > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
> > > 
> > > Here is a picture of some traceback
> > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
> > 
> > 
> 
> It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?

Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?

thanks,

greg k-h
