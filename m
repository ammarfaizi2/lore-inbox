Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWBHDDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWBHDDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBHDDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:03:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750867AbWBHDDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:03:51 -0500
Date: Tue, 7 Feb 2006 22:03:35 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060208030335.GC17665@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
	Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <20060207234043.GB17665@redhat.com> <20060208000715.GA19233@kroah.com> <200602080110.06736.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080110.06736.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:10:06AM +0100, Andi Kleen wrote:
 > On Wednesday 08 February 2006 01:07, Greg KH wrote:
 > 
 > > > In the meantime, here's what I got..
 > > > 
 > > > http://people.redhat.com/davej/DSC00148.JPG
 > > 
 > > Andi, didn't your change for this function make it into Linus's tree?
 > 
 > Yes
 > 
 > See
 > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1de6bf33bc4601d856c286ad5c7d515468e24bbb
 > 
 > Workaround is pci=nommconf btw

I'm puzzled.  I'm still seeing this crash with latest -git which
has this patch (I just double checked the source I built).
The pci=nommconf workaround does indeed work though.

		Dave
