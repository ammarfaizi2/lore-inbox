Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWHVIB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWHVIB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWHVIB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:01:57 -0400
Received: from mail.suse.de ([195.135.220.2]:54680 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751164AbWHVIB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:01:56 -0400
From: Andi Kleen <ak@suse.de>
To: Tim Hockin <thockin@google.com>
Subject: Re: PCI MMCONFIG aperture size
Date: Tue, 22 Aug 2006 09:55:31 +0200
User-Agent: KMail/1.9.3
Cc: matthew@wil.cx, greg@kroah.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@google.com>
References: <20060822024237.GO16573@google.com>
In-Reply-To: <20060822024237.GO16573@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608220955.31620.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This says to me that (as long as the MCFG table has an End Bus Number of
> 31) a 32 MB decode area (32 MB aligned, too) is valid.
> 
> Would something like the below patch be accepted?  It makes my system
> work...


I already got a patch to remove the complete e820 validation code because
it broke far more than it fixed. That should fix your problem too.
 
> Also, why are we forcing 32 bit base addresses?  ACPI defines it to be a
> 64 bit base...

Where do you think we do that?

-Andi
