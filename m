Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268369AbUIGSUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268369AbUIGSUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGSRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:17:48 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:29301 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268334AbUIGSOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:14:32 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
Date: Tue, 7 Sep 2004 20:04:03 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20040906174447.238788D1E@zion.localdomain> <20040906142641.067fdeb6.akpm@osdl.org>
In-Reply-To: <20040906142641.067fdeb6.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072004.03343.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 September 2004 23:26, Andrew Morton wrote:
> Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
> of your patches.  Please prepare an English-language summary.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
Ok, but how can I specify the filename you'll give to the patch?

It would make management between my tree and yours easier for me, if possible.

> I applied three of these - two got rejects against Linus's current
> tree.
>
> Do you have to do this
>
>  -menu "SCSI support"
>  +if BROKEN
>  +	menu "SCSI support"
>
>  -config SCSI
>
> I think you'll find that
>
> 	menu "SCSI support"
> 	depends on BROKEN
>
> works OK.
If you want to add the dependency to SCSI, GENERIC_ISA_DMA and every item in 
arch/um/Kconfig_scsi by hand, you're welcome, but I guess not :-).

Otherwise, please note I bracketed everything with if BROKEN....endif. If you 
don't like the indent, that's not a problem.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
