Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWGNThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWGNThU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWGNThU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:37:20 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:65441 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422729AbWGNThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:37:19 -0400
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Fri, 14 Jul 2006 12:37:14 -0700
User-Agent: KMail/1.7.1
Cc: "Andy Chittenden" <AChittenden@bluearc.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>
References: <89E85E0168AD994693B574C80EDB9C270464C6DC@uk-email.terastack.bluearc.com> <20060714093014.2a6e68ff.akpm@osdl.org>
In-Reply-To: <20060714093014.2a6e68ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141237.15503.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 9:30 am, Andrew Morton wrote:
> 
> But when the flock returns, hopefully they will remember that we have a
> straightforward box-killing regression in the 2.6.17 OHCI controller quirk
> handling.

More likely in some other code, since that "quirk" handling code hasn't
changed in forever.  Sometimes BIOS changes hurt (including setup/config),
sometimes pci/acpi init is a factor.

- Dave

