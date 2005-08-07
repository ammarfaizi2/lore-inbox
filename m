Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVHGHiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVHGHiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVHGHiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:38:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751205AbVHGHiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:38:20 -0400
Date: Sun, 7 Aug 2005 00:36:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris White <chriswhite@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Logitech Quickcam Express USB Address Aquisition Issues
Message-Id: <20050807003639.0aa1d9b3.akpm@osdl.org>
In-Reply-To: <20050807160222.0c4ee412@localhost>
References: <20050807160222.0c4ee412@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris White <chriswhite@gentoo.org> wrote:
>
> [Pre Note: please CC me all responses, thanks]
> 
> Currently, I have a Logitech Quickcam Express webcamera.  Unfortunately, it
> seems to have issues getting assigned an address.  I quote the following
> from dmesg:
> 
> usb 1-1.1: new full speed USB device using ehci_hcd and address 11
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 12
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 13
> usb 1-1.1: device not accepting address 13, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 14
> usb 1-1.1: device not accepting address 14, error -32
> 
> As far as the host goes, I have the following USB hosts:
> 
> 0000:00:11.0 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.1 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 
> The first is my builtin Intel USB controller, the second is one belkin
> USB 1.0 card, and another 2.0 card.  I've tried it in all three just to
> verify one of my hosts wasn't broken.  Considering my printer works with
> it, as well as my scanner, I'm sort of thinking that's not an issue.
> 
> I searched up google a bit and recieved some warnings about acpi causing
> problems, so I disabled that, but was still unsucessful in getting that to
> work.  Please let me know if any other information is required.  Thanks
> ahead of time.
> 

(Added linux-usb-devel)

Which kernel version?

Did it work OK under a previous kernel version?  If so, which?

