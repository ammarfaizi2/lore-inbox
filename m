Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUJSE4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUJSE4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 00:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJSE4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 00:56:20 -0400
Received: from jpnmailout01.yamato.ibm.com ([203.141.80.81]:49821 "EHLO
	jpnmailout01.yamato.ibm.com") by vger.kernel.org with ESMTP
	id S267935AbUJSE4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 00:56:19 -0400
In-Reply-To: <200410182041.02192.david-b@pacbell.net>
Subject: Re: [ACPI] Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
To: David Brownell <david-b@pacbell.net>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
X-Mailer: Lotus Notes Release 6.0.2CF2 July 23, 2003
Message-ID: <OF79267D02.4622732F-ON49256F32.001A8322-49256F32.001A98B9@jp.ibm.com>
From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Date: Tue, 19 Oct 2004 13:55:32 +0900
X-MIMETrack: Serialize by Router on D19ML115/19/M/IBM(Release 6.51HF338 | June 21, 2004) at
 2004/10/19 13:55:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





David Brownell wrote:

>So what would that patch need before ACPI could convert to use it?

>I didn't notice any obvious associations between the strings in
>the acpi/wakeup file and anything in sysfs.  Which of USB1..USB4
>was which of the three controllers shown by "lspci" (and which
>one was "extra"!), as one head-scratcher.

>For PCI, I'd kind of expect pci_enable_wake() to trigger the
>additional ACPI-specific work to make sure the device can
>actually wake that system.   Seems like dev->platform_data
>might need to combine with some platform-specific API hook.

>- Dave

Does anoyone give me a link to the original RFC?
I cannot find the original mail as a newbie associated with this list.

Hiro.

