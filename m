Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVHJIFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVHJIFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVHJIFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:05:49 -0400
Received: from smtp.istop.com ([66.11.167.126]:54430 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S965043AbVHJIFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:05:48 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Date: Wed, 10 Aug 2005 18:06:09 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <42F57FCA.9040805@yahoo.com.au> <200508100923.55749.phillips@arcor.de> <Pine.LNX.4.61.0508100843420.18223@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508100843420.18223@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508101806.09532.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 August 2005 17:48, Hugh Dickins wrote:
> On Wed, 10 Aug 2005, Daniel Phillips wrote:
> > --- 2.6.13-rc5-mm1.clean/include/linux/page-flags.h	2005-08-09
> > 18:23:31.000000000 -0400 +++
> > 2.6.13-rc5-mm1/include/linux/page-flags.h	2005-08-09 18:59:57.000000000
> > -0400 @@ -61,7 +61,7 @@
> >  #define PG_active		 6
> >  #define PG_slab			 7	/* slab debug (Suparna wants this) */
> >
> > -#define PG_checked		 8	/* kill me in 2.5.<early>. */
> > +#define PG_miscfs		 8	/* kill me in 2.5.<early>. */
> >  #define PG_fs_misc		 8
>
> And all those PageMiscFS macros you're adding to the PageFsMisc ones:
> doesn't look like progress to me ;)

Heh, it looks like part of a patch did creep into Andrew's tree already.  I'll 
fix it on the morrow.

Regards,

Daniel
