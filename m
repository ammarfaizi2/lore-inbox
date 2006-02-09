Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWBIU6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWBIU6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBIU6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:58:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750784AbWBIU6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:58:17 -0500
Date: Thu, 9 Feb 2006 15:57:54 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Neal Becker <ndbecker2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060209205754.GD9576@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
	Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <200602080110.06736.ak@suse.de> <20060208030335.GC17665@redhat.com> <200602080855.06000.ak@suse.de> <20060209204940.GC9576@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209204940.GC9576@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 03:49:40PM -0500, Dave Jones wrote:
 > On Wed, Feb 08, 2006 at 08:55:05AM +0100, Andi Kleen wrote:
 >  > >  > Workaround is pci=nommconf btw
 >  > > I'm puzzled.  I'm still seeing this crash with latest -git which
 >  > > has this patch (I just double checked the source I built).
 >  > 
 >  > That's surprising. Can you addr2line the exactly address it's crashing on?
 > 
 > Still there in todays git snapshot.
 > http://people.redhat.com/davej/dsc00150.jpg is the top of the oops.

Actually I think this is pilot error.  I've been running a mispatched tree.

		Dave

