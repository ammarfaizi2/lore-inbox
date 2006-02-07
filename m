Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWBGXbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWBGXbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWBGXbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:31:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030267AbWBGXbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:31:20 -0500
Date: Tue, 7 Feb 2006 18:30:59 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060207233059.GA17665@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <ds7f17$gp7$1@sea.gmane.org> <20060207145913.714fec1c.akpm@osdl.org> <20060207231835.GA19648@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207231835.GA19648@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:18:35PM -0800, Greg Kroah-Hartman wrote:
 > On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
 > > Neal Becker <ndbecker2@gmail.com> wrote:
 > > >
 > > > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
 > > > 
 > > > Neal Becker wrote:
 > > > 
 > > > > HP dv8000 notebook
 > > > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
 > > > > 
 > > > > Here is a picture of some traceback
 > > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
 > > > 
 > > > 
 > > 
 > > It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?
 > 
 > Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?

I can hit this on my dv8000 too. It's still there in 2.6.12-rc2-git3
I'm building a kernel with Randy's 'pause after printk' patch right now
to catch the top of the oops.  It's enormous.  Even with a 50 line display,
and x86-64s dual-line backtrace, it scrolls off the top.

		Dave

