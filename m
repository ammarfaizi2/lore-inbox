Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWH3H3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWH3H3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 03:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWH3H3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 03:29:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:2976 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750839AbWH3H3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 03:29:11 -0400
From: Andi Kleen <ak@suse.de>
To: kmannth@us.ibm.com
Subject: Re: [BUG] 2.6.18-rc4-mm3 x86_64-mm-spin-irqs-enabled causes problems
Date: Wed, 30 Aug 2006 09:28:36 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, andrew <akpm@osdl.org>,
       efalk@google.com
References: <1156895977.5654.17.camel@keithlap>
In-Reply-To: <1156895977.5654.17.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608300928.36175.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 01:59, keith mannthey wrote:
> Hello, 
>   I moved to mm2 to mm3 and had trouble booting again with my hardware.
> In -mm3 the kernel boots but about the time init starts the whole box
> just stops doing anything.  Sysrq works and I dumped the tasks but
> nothing look too far out of place.  
> 
> I did a bisection of -mm3 and found x86_64-mm-spin-irqs-enabled.patch to
> be the cause. 

Yes it also broke someone else's box. We know what is broken now,
but the patch is dropped alreayd anyways because it had other issues too.

-Andi

