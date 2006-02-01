Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWBAJvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWBAJvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBAJvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:51:17 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:21642 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1030272AbWBAJvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:51:16 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Date: Wed, 1 Feb 2006 09:51:08 +0000
User-Agent: KMail/1.8.2
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601311856.17569.a1426z@gawab.com> <986ed62e0601312006y75748bd9x8925556e979d59c9@mail.gmail.com>
In-Reply-To: <986ed62e0601312006y75748bd9x8925556e979d59c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010951.08967.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 04:06, Barry K. Nathan wrote:
>
> Also, the only way I see where "there is no more swapping" and
> "[y]ou're dealing with memory only" is if the disk *becomes* main
> memory, and main memory becomes an L3 (or L4) cache for the CPU [and
> as a consequence, main memory also becomes the main form of long-term
> storage]. Is that what you're proposing?
>

In the not-too-distant future, there is likely to be a ram/disk price 
inversion; ram becomes cheaper/mb than disk. At that point, we'll be buying 
hardware based on "how much disk can I afford to provide power-off backup of 
my ram?" rather than "how much ram can I afford?"

At that point, things will change.

Maybe, then, everything _will_ be in ram (with the kernel will intelligently 
write out pages to the disk in the background, incase of power failure and 
ready for a shutdown). Disk reads only ever occur during a power-on 
population of ram.

Blue skys....

Andrew Walrond
