Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUJCTHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUJCTHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 15:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUJCTHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 15:07:22 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:9409 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268088AbUJCTHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 15:07:21 -0400
Message-ID: <9e47339104100312075ed923e0@mail.gmail.com>
Date: Sun, 3 Oct 2004 15:07:20 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Hanno Meyer-Thurow <h.mth@web.de>
Subject: Re: 2.6.9-rc3-mm1, bk-pci patch, USB hubs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041003210237.1c1a6132.h.mth@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041003210237.1c1a6132.h.mth@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't check them individually, I just reverted the group. UHCI
fails for me, this fixes it. EHCI and OHCI are of unknown status for
me since I don't know if they failed too.

On Sun, 3 Oct 2004 21:02:37 +0200, Hanno Meyer-Thurow <h.mth@web.de> wrote:
> Hi Jon,
> 
> > These changes make the USB hub module fail to load. I get a trap in
> > kmem_cache_alloc called from uhci_alloc_urb_private. Reverting them
> > fixes it.
> 
> I use EHCI and UHCI and i just had to revert only the part for UHCI. EHCI works just fine here!

-- 
Jon Smirl
jonsmirl@gmail.com
