Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275368AbTHMURF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275369AbTHMURF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:17:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49573 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275368AbTHMURD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:17:03 -0400
Date: Wed, 13 Aug 2003 21:16:11 +0100
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813201610.GJ12953@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
	Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com> <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:54:12PM +0100, Matthew Wilcox wrote:
 > 
 > So I took the driver module, put it on a floppy, hand-edited the binary
 > to replace one of the PCI IDs with the ones that came back from lspci.
 > Stuck the floppy back in the Evo, loaded the hacked module and finished
 > the install.  Then compiled a new kernel ;-)
 > 
 > I haven't seen anything to address this in a nicer way yet.

This situation is exactly what the new_id stuff in sysfs is for AIUI.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
