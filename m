Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUK2IFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUK2IFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 03:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUK2IFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 03:05:34 -0500
Received: from colino.net ([213.41.131.56]:7919 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261292AbUK2IFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 03:05:18 -0500
Date: Mon, 29 Nov 2004 09:04:06 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
 take)
Message-ID: <20041129090406.5fb31933@pirandello>
In-Reply-To: <1101507130.28047.29.camel@gaston>
References: <20041126113021.135e79df@pirandello>
	<200411260928.18135.david-b@pacbell.net>
	<20041126183749.1a230af9@jack.colino.net>
	<200411260957.52971.david-b@pacbell.net>
	<1101507130.28047.29.camel@gaston>
X-Mailer: Sylpheed-Claws 0.9.12cvs169.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 2004 at 09h11, Benjamin Herrenschmidt wrote:

Hi, 

> > > It's probably a linux-wlan-ng issue... 
> > 
> > I suspect PPC resume issues myself.
> 
> Colin, you didn't tell us which controller it was ? The NEC one is a
> totally normal off-the-shelves controller coming out of D3. The Apple
> ones are a bit special tho.

It's the ibook G4's controller:
[colin@jack ~]$ for i in 1 2 3 4; do cat /sys/bus/usb/devices/usb$i/product; done;
NEC Corporation USB 2.0
Apple Computer Inc. KeyLargo/Intrepid USB (#3)
NEC Corporation USB
NEC Corporation USB (#2)


-- 
Colin
