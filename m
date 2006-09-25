Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWIYUuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWIYUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWIYUuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:50:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:411 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751054AbWIYUuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:50:14 -0400
From: Andi Kleen <ak@suse.de>
To: jeremy@goop.org
Subject: Re: [PATCH 1/6] Initialize the per-CPU data area.
Date: Mon, 25 Sep 2006 22:49:54 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
References: <20060925184540.601971833@goop.org> <20060925184638.385115998@goop.org>
In-Reply-To: <20060925184638.385115998@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609252249.54901.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -r 1555a09108d1 include/asm-i386/pda.h
> --- a/include/asm-i386/pda.h	Sun Sep 24 19:18:35 2006 -0700
> +++ b/include/asm-i386/pda.h	Mon Sep 25 01:46:27 2006 -0700
> @@ -1,8 +1,12 @@
>  #ifndef _I386_PDA_H
>  #define _I386_PDA_H
>  
> +#include <linux/stddef.h>

If this is really 1/1 why does it patch a file called pda.h? 

I've thrown away the local pda patches before this because I assumed
you started fresh.

Somehow I'm not surprised that nothing applies.  You seem to always
start with some random tree that nobody else has.

Anyways, this patchkit has caused so much trouble and churn that I'll drop
it for now until after the .19 merge is done.

-Andi
