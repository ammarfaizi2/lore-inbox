Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCXXOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCXXOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVCXXOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:14:45 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:25475 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261232AbVCXXOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:14:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
Date: Fri, 25 Mar 2005 00:14:38 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
References: <20050322013535.GA1421@elf.ucw.cz> <200503240049.25695.rjw@sisk.pl> <1111626180.17317.921.camel@d845pe>
In-Reply-To: <1111626180.17317.921.camel@d845pe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503250014.38550.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 24 of March 2005 02:03, Len Brown wrote:
> On Wed, 2005-03-23 at 18:49, Rafael J. Wysocki wrote:
]-- snip --[ 
> I'd believe that ohci_hcd and ehci_hcd are fragile since glancing
> at their lengthy .resume routines it isn't immediately obvious
> that they do this.  But yenta_dev_resume has a pci_enable_device(),
> so that failure may be less straightforward.
>
> cheers,
> -Len
>
> ps. if point me to a full dmesg -s64000 from 2.6.12-rc1 acpi-enabled 
> boot, that would help -- for it will show if we're even using pci
> interrupt links (and programming them) for these devices on this box.

The dmesg output is at:
http://www.sisk.pl/kernel/050325/2.6.11-rc1-dmesg.log

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
