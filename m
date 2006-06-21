Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWFUUgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWFUUgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWFUUgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:36:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18408 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030268AbWFUUgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:36:51 -0400
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
	underruns, USB HDD hard resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andi@lisas.de, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, hal@lists.freedesktop.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0606211502510.8272-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0606211502510.8272-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 21:52:03 +0100
Message-Id: <1150923123.15275.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 15:06 -0400, ysgrifennodd Alan Stern:
> > cdrecord is -dev=0,0,0 (whatever Linux device file this translates into)
> > or a similar device ID as returned by -scanbus.
> 
> That goes through the sg driver.

Use a cdrecord that understands SG_IO and dev=/dev/sr0

