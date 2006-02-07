Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWBGXfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWBGXfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWBGXfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:35:36 -0500
Received: from xenotime.net ([66.160.160.81]:17054 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030280AbWBGXff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:35:35 -0500
Date: Tue, 7 Feb 2006 15:35:31 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Dave Jones <davej@redhat.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Neal Becker <ndbecker2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
In-Reply-To: <20060207233059.GA17665@redhat.com>
Message-ID: <Pine.LNX.4.58.0602071534380.12589@shark.he.net>
References: <ds7cu3$9c0$1@sea.gmane.org> <ds7f17$gp7$1@sea.gmane.org>
 <20060207145913.714fec1c.akpm@osdl.org> <20060207231835.GA19648@kroah.com>
 <20060207233059.GA17665@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Dave Jones wrote:

> On Tue, Feb 07, 2006 at 03:18:35PM -0800, Greg Kroah-Hartman wrote:
>  > On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
>  > > Neal Becker <ndbecker2@gmail.com> wrote:
>  > > >
>  > > > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
>  > > >
>  > > > Neal Becker wrote:
>  > > >
>  > > > > HP dv8000 notebook
>  > > > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
>  > > > >
>  > > > > Here is a picture of some traceback
>  > > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
>  > > >
>  > > >
>  > >
>  > > It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?
>  >
>  > Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?
>
> I can hit this on my dv8000 too. It's still there in 2.6.12-rc2-git3
> I'm building a kernel with Randy's 'pause after printk' patch right now
> to catch the top of the oops.  It's enormous.  Even with a 50 line display,
> and x86-64s dual-line backtrace, it scrolls off the top.

Just be patient.  A boot can take a few minutes... ;)

-- 
~Randy
