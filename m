Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVGVIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVGVIsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVGVIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:48:12 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:24492 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262069AbVGVIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:48:10 -0400
Date: Fri, 22 Jul 2005 10:48:05 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DriveStatusError BadCRC
Message-ID: <20050722084805.GA10207@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005, sampei02@tiscali.it wrote:

> I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving this
> message:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }

> How can I solve it ?

Check your hardware. ATA cables must not exceed 45 cm in length; for
Ultra DMA 4, 5 or 6 (66 MByte/s and faster), you need to use 80-wire
cables (they need extra ground lines for shielding), and check if all
plugs are seated properly.

WRT the backtrace you showed, someone else will have to answer - which
kernel version are you using? If it's a Fedora-patched kernel, report
the problem to the Fedora project. If it's an older unmodified kernel,
retry with a newer kernel (2.6.12.3) first and see if the problem is
still present.

-- 
Matthias Andree
