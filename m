Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUJKPuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUJKPuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJKPZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:25:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:42909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268957AbUJKPWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:22:49 -0400
Date: Mon, 11 Oct 2004 08:17:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <416A5857.1090307@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A5857.1090307@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Nick Piggin wrote:
> 
> ACPI still explodes on my old PII and stops it booting. (I've reported it
> to Len a few times but he seems to be ignoring me).

I suspect the "CONFIG_ACPI_BLACKLIST_YEAR" might be the solution they came 
up with. Old ACPI stuff tends to be broken.

That said, your patch is small and simple, so..

		Linus
