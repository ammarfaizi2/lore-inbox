Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267991AbUBRT52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267988AbUBRT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:57:28 -0500
Received: from palrel13.hp.com ([156.153.255.238]:24541 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267974AbUBRT5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:57:25 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.50076.400669.872965@napali.hpl.hp.com>
Date: Wed, 18 Feb 2004 11:57:16 -0800
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
In-Reply-To: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 08:41:18 -0600 (CST), Pat Gefre <pfg@sgi.com> said:

  Pat> Here's a small mod for Altix. It breaks up our 'pci fixup' function and
  Pat> has some other smallish clean ups.

  Pat> For the ia64 crowd I've added 'platform_data' back into
  Pat> include/asm-ia64/pci.h

I added this patch in my tree now with some trailing white-space
fixes, but no other changes.

As far as I can tell, platform_data never was in the the struct
pci_controller of the 2.5/2.6 tree, so it's really a new thing, not a
matter of "adding it back" (yeah it's in 2.4, but that's a separate
tree...).

	--david
