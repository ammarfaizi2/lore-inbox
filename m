Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVJDMCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVJDMCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVJDMCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:02:18 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:20740 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932387AbVJDMCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:02:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mSDgfdPMKW93OMbUZGKj20kwmlcX10ZnINB7Jf6YKLBTH9pw9x1ji5kqbIdzVM9PVdmn8FwO9ySYHz0g/uqwtBFaAW4KyEbGIiPPUQT8fCp8fQe/ozWT/0itfGRwikZn05uTyyR1ObUOSXW377VXhEY6GFnHEwPrbbJw9R5durU=
Date: Tue, 4 Oct 2005 21:02:10 +0900
From: Tejun Heo <htejun@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Message-ID: <20051004120210.GA2622@htj.dyndns.org>
References: <43426EB4.6080703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43426EB4.6080703@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry, corrections.

On Tue, Oct 04, 2005 at 08:59:48PM +0900, Tejun Heo wrote:
> 
>  Hello, Andi.
> 
>  In include/asm-x86_64/page.h, __VIRTUAL_MASK_SHIFT is defined as 48 
> bits which is the size of virtual address space on current x86_64 
> machines as used as such.  OTOH, __PHYSICAL_MASK_SHIFT is defined as 46 
           and used as such.
> and used as mask shift for physical page address (i.e. physaddr >> 12).
                             physical page number (i.e. physaddr >> 12).

 Sorry about extra noise, I gotta eat something, feeling dizzy.  :-)

-- 
tejun
