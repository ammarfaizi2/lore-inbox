Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271245AbTHMAuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTHMAuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:50:24 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28579 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S271245AbTHMAuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:50:23 -0400
Date: Wed, 13 Aug 2003 01:49:42 +0100
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, willy@debian.org,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813004941.GD2184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	greg@kroah.com, willy@debian.org, davem@redhat.com,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812173742.6e17f7d7.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 05:37:42PM -0700, Randy.Dunlap wrote:
 > | I would much rather move the PCI ids out of the 
 > | drivers altogether, into some metadata file(s) in the kernel source 
 > | tree, than bloat up tg3, tulip, e100, and the other PCI id-heavy 
 > | drivers' source code.
 > 
 > That last few lines certainly sounds desirable.

What exactly would be the benefit of this ?
The only thing I could think of was out-of-kernel tools to do
things like matching modules to pci IDs, but that seems to be
done mechanically by various distros already reading the pci_driver
structs.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
