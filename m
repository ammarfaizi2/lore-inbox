Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUIJTDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUIJTDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUIJTDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:03:23 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:56409 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267708AbUIJTDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:03:16 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [patch 1/1] uml-update-2.6.8-finish
Date: Fri, 10 Sep 2004 20:59:58 +0200
User-Agent: KMail/1.6.1
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20040908173855.68F518D0B@zion.localdomain>
In-Reply-To: <20040908173855.68F518D0B@zion.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409102059.58454.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 19:38, blaisorblade_spam@yahoo.it wrote:
> Add some updates for API changes in 2.6.8 which were not included in the
> original UML patch; these fixes were detected by some warnings, so I
> probably missed some more ones.
Well, Andrew, this one should go in, please. No review should be needed, I 
hope.
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
>
>  uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h |    2 ++
>  1 files changed, 2 insertions(+)
>
> diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish
> include/asm-um/dma-mapping.h ---
> uml-linux-2.6.8.1/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004
>-09-07 15:17:57.593456048 +0200 +++
> uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h	2004-09-07
> 15:17:57.595455744 +0200 @@ -1,6 +1,8 @@
>  #ifndef _ASM_DMA_MAPPING_H
>  #define _ASM_DMA_MAPPING_H
>
> +#include <asm/scatterlist.h>
> +
>  static inline int
>  dma_supported(struct device *dev, u64 mask)
>  {
> _
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
