Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUC3Byo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUC3Byo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:54:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:32758 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263480AbUC3Bym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:54:42 -0500
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329164701.0edff5e4.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1080606618.6742.89.camel@arrakis>  <20040329164701.0edff5e4.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080611633.6742.149.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 17:53:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 16:47, Paul Jackson wrote:
> The following typo needs fixing.  I had double opening
> brace, instead of parenthesis-brace.  Time to increase
> my screen font size.
> 
> ===== include/linux/mask.h 1.3 vs edited =====
> --- 1.3/include/linux/mask.h    Mon Mar 29 17:10:27 2004
> +++ edited/include/linux/mask.h Mon Mar 29 17:37:01 2004
> @@ -352,13 +352,13 @@
>  })
> 
>  #define MASK_ALL(nbits)
> -{{
> +({
>         [0 ... BITS_TO_LONGS(nbits)-1] = ~0UL,
>         [BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)
>  }}
> 
>  #define MASK_NONE(nbits)
> -{{
> +({
>         [0 ... BITS_TO_LONGS(nbits)-1] =  0UL
>  }}

Might want to fix the double closing braces as well.

Definitely time to increase your font size! ;)

-Matt

