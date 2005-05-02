Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVEBTgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVEBTgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVEBTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:36:08 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:11145 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261730AbVEBTgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:36:06 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Setting the hardware clock together with the system one(was: Re: [patch 1/1] x86_64: make string func definition work as intended)
Date: Mon, 2 May 2005 21:36:41 +0200
User-Agent: KMail/1.8
References: <20050501190851.5FD5B45EBB@zion> <20050501155327.GX3592@stusta.de>
In-Reply-To: <20050501155327.GX3592@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505022136.42202.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 May 2005 17:53, Adrian Bunk wrote:
> On Sun, May 01, 2005 at 09:08:51PM +0200, blaisorblade@yahoo.it wrote:
> >...                    ^^^^^^^^^^^^^^^^
>
> Please correct the time settings on your computer.
I'm doing it by hand at every reboot. Just discovered this stupid Gentoo 
default setting:

# If you want to sync the system clock to the hardware clock during
# shutdown, then say "yes" here.

CLOCK_SYSTOHC="no"

In other words, the kernel does not auto-adjusts the hardware clock? Well, 
that's not nice... (maybe only the Gentoo setting).

Regards.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

