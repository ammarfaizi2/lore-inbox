Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265965AbUFOU6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUFOU6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUFOU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:58:09 -0400
Received: from verein.lst.de ([212.34.189.10]:20677 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265965AbUFOU57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:57:59 -0400
Date: Tue, 15 Jun 2004 22:57:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: more files with licenses that aren't GPL-compatible
Message-ID: <20040615205753.GA24380@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I don't want to jump into the usual Debian wankfest whether Linux
as GPL'ed project can distribute hex-images of firmware at all there are
a few firmware C headers files that have a license statement that aren't
GPL-compatible at all, namely the keyspan firmware in
drivers/usb/serial/keyspan*_fw.h with the following license text:


---------------------------- snip ----------------------------
	The firmware contained herein as keyspan_mpr_fw.h is

		Copyright (C) 1999-2001
		Keyspan, A division of InnoSys Incorporated ("Keyspan")
		
	as an unpublished work. This notice does not imply unrestricted or
	public access to the source code from which this firmware image is
	derived.  Except as noted below this firmware image may not be 
	reproduced, used, sold or transferred to any third party without 
	Keyspan's prior written consent.  All Rights Reserved.

	Permission is hereby granted for the distribution of this firmware 
	image as part of a Linux or other Open Source operating system kernel 
	in text or binary form as required. 

	This firmware may not be modified and may only be used with  
	Keyspan hardware.  Distribution and/or Modification of the 
	keyspan.c driver which includes this firmware, in whole or in 
	part, requires the inclusion of this statement."
---------------------------- snip ----------------------------

which makes the kernel as whole unredistributable.  A similar license
was according to Greg also recently granted for
drivers/usb/misc/emi62_fw_*.h which currently has even worse license
statements in there.

Does someone have good contacts to keyspan to get it under a more
suitable license?
