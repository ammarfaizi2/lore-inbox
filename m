Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVJSVfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVJSVfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVJSVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:35:38 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:2330 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751360AbVJSVfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:35:37 -0400
To: gcoady@gmail.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: cleanup comments
X-Message-Flag: Warning: May contain useful information
References: <4eedl1h86sarh1i5g42o7vi21i7v1ece2m@4ax.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 19 Oct 2005 14:35:25 -0700
In-Reply-To: <4eedl1h86sarh1i5g42o7vi21i7v1ece2m@4ax.com> (Grant Coady's
 message of "Thu, 20 Oct 2005 07:27:41 +1000")
Message-ID: <524q7di40y.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 19 Oct 2005 21:35:26.0493 (UTC) FILETIME=[04F15CD0:01C5D4F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think I like this.  I prefer the format

	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */

to taking two lines like

	/* PCI-Cbus Bridge */
	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001

If some script can't handle the first format then I think the script
should be fixed.

 - R.
