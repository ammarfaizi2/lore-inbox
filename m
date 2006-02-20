Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWBTK5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWBTK5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBTK5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:57:05 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:56784 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964881AbWBTK5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:57:03 -0500
Date: Mon, 20 Feb 2006 11:57:00 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: readahead logic and I/O errors
Message-ID: <20060220105700.GB5918@harddisk-recovery.nl>
References: <43F39089.2050302@tls.msk.ru> <200602160853.16297.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602160853.16297.jk-lkml@sci.fi>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 08:53:16AM +0200, Jan Knutar wrote:
> Sorry for hijacking the thread, but on another note, is there
> anyway to tell linux to tell the drive to not bother retrying
> read errors? Would be perfect for streaming video from a
> CD or DVD. Usually video players have excellent error
> recovery themselves, which probably looks better on the
> screen than the movie coming to a grinding halt due to
> the retries.

FWIW, ATAPI defines a streaming IO command set, but that isn't uses by
any driver.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
