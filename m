Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWBIKCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWBIKCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBIKCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:02:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:65206 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422657AbWBIKCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:02:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH/RFC] arch/x86_common: more formal reuse of i386+x86_64 source code
Date: Thu, 9 Feb 2006 10:59:40 +0100
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20060208225336.23539710.rdunlap@xenotime.net>
In-Reply-To: <20060208225336.23539710.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602091059.40319.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 07:53, Randy.Dunlap wrote:
> (not completed yet)
> (patch applies to 2.6.16-rc2)
> 
> Patch is 331 KB and is at
>   http://www.xenotime.net/linux/patches/x86-common1.patch
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Move lots of i386 & x86_64 common code into arch/x86_common/
> and modify Makefiles to use it from there.

No. That patch doesn't buy us anything and makes it hell
to forward/backward port patches.

-Andi
