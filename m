Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUIGMAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUIGMAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUIGMAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:00:00 -0400
Received: from pat.uio.no ([129.240.130.16]:56049 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267903AbUIGL7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:59:54 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
References: <20040907020831.62390588.akpm@osdl.org>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Tue, 07 Sep 2004 13:59:34 +0200
In-Reply-To: <20040907020831.62390588.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 7 Sep 2004 02:08:31 -0700")
Message-ID: <wxxoekil26x.fsf@nommo.uio.no>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
> 
> - Added Dave Howells' mysterious CacheFS.
> - Various new fixes, cleanups and bugs, as usual.

  the sk98lin driver in the kernel is getting to be rather old, and
  doesn't support things like the Marvel 88E8053 found on Asus P5AD2
  Deluxe motherboards.  the installation tool from SysKonnect comes
  with a patch generator, which makes everything nice and tidy, but
  the patch is huge against any current kernel.  against 2.6.9-rc1-mm4
  we're looking at just over a megabyte.

  I have however tested the driver against a few chipsets with 2.6.7
  and 2.6.9-rc1-mm4, and it seems to work for me[tm].  I can happily
  produce the patch for either of these kernels if need be.

  oh, and the version of the driver I've tested, version 7.07, finally
  works with tools like pcimodules.
 

-- 
Terje
