Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTD1STp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTD1STp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:19:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22235 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261239AbTD1STo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:19:44 -0400
To: davidm@hpl.hp.com
cc: Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Dave Hansen <haveblue@us.ibm.com>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@williams.name>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lse-tech] Re: maximum possible memory limit .. 
In-reply-to: Your message of Mon, 28 Apr 2003 10:53:53 PDT.
             <16045.27313.369493.99346@napali.hpl.hp.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22244.1051554664.1@us.ibm.com>
Date: Mon, 28 Apr 2003 11:31:04 -0700
Message-Id: <E19ADP6-0005mq-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003 10:53:53 PDT, David Mosberger wrote:
> >>>>> On Mon, 28 Apr 2003 19:13:53 +0200, Andi Kleen <ak@suse.de> said:
> 
>   >> Cool. Sorry to be pestering about the 64-bit limits, but can we
>   >> really use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.?
>   >> (AFAIK, 64-bit arches don't suffer from a small ZONE_LOWMEM.)
> 
>   Andi> No. The hardware have far smaller physical limits.
> 
>   Andi> Current AMD64 CPUs are limited to 40bit physical, 48bit virtal
>   Andi> (the virtual limit per process in the current Linux kernel is
>   Andi> 39bits)
> 
>   Andi> Itanium 2 afaik support a bit more 50bits (51 or 52, I forgot)
>   Andi> physical, probably more virtual.
> 
> Itanium 2 supports all 64 virtual address bits and 50 physical bits
> (in what way is "1024 times more" "a bit more"? ;-).
> 
> 	--david

0x400 is just one more bit, albeit slid around a byte or two.  ;)

gerrit
