Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJWRwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJWRwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:52:24 -0400
Received: from intra.cyclades.com ([64.186.161.6]:37333 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261151AbTJWRwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:52:23 -0400
Date: Thu, 23 Oct 2003 15:48:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Peter Osterlund <petero2@telia.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre8
In-Reply-To: <m23cdjopfn.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.44.0310231548230.3129-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 Oct 2003, Peter Osterlund wrote:

> The toplevel Makefile contains this change which looks like a typo:
> 
> @@ -28,7 +28,7 @@
>  AS             = $(CROSS_COMPILE)as
>  LD             = $(CROSS_COMPILE)ld
>  CC             = $(CROSS_COMPILE)gcc
> -CPP            = $(CC) -E
> +PP             = $(CC) -E
>  AR             = $(CROSS_COMPILE)ar
>  NM             = $(CROSS_COMPILE)nm
>  STRIP          = $(CROSS_COMPILE)strip

Yes its a typo. Its in fixed in the BK tree.



