Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULTXdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULTXdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULTXaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:30:01 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:30113 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261678AbULTX0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:26:15 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Attila BODY <compi@freemail.hu>
Subject: Re: USB storage (pendrive) problems
Date: Mon, 20 Dec 2004 23:25:19 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <1103579679.23963.14.camel@localhost>
In-Reply-To: <1103579679.23963.14.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412202325.20064.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 December 2004 21:54, Attila BODY wrote:
> Hi,
>
> I have some weird problems with my pendrives recently. I just compile a
> 2.6.9 to check if the problem is still exists there.
>
> current kernel is 2.6.10-rc3 and the situation is the following:
>
> If I copy more than few megabytes to the drive, the activity LED keeps
> flashing forever. sync, umount keeps runing forever, normal reboot is
> inpossible (alt+sysreq+b seems to work)
>
> Tested with usb 1.1 and 2.0 pendrives, behaviour is the same.
>

I'm doing exactly that with 2.6.10-rc3. umount does take a very long time (but 
I had just written 600Mb+ over usb 1.1)

Are you sure it doesn't come back if you leave it long enough?

Do the throughput sums; you'll be suprised how long it takes to send more than 
a few Mb over usb 1.1 (1.5Mb/s). Eg 600Mb = 7minutes

Usb 2 should be much faster; Do you have EHCI loaded?

Andrew Walrond
