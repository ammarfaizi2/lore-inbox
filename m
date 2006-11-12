Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754919AbWKLM27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbWKLM27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbWKLM27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:28:59 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:15301 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1754919AbWKLM26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:28:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Sun, 12 Nov 2006 13:26:12 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru>
In-Reply-To: <200611121436.46436.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121326.12309.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 12 November 2006 12:36, Andrey Borzenkov wrote:
> This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when
> I switch on the system after suspend to disk. Actually, after kernel has been
> loaded, the whole resuming (up to the point I have usable desktop again)
> takes about three time less than the process of loading kernel + initrd.
> During loading disk LED is constantly lit. This almost looks like kernel
> leaves HDD in some strange state, although I always assumed HDD/IDE is
> completely reinitialized in this case.

Can you please see what's in the /sys/power/disk file?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
