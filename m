Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVCCCPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVCCCPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCCML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:12:11 -0500
Received: from holomorphy.com ([66.93.40.71]:28336 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261348AbVCCCBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:01:09 -0500
Date: Wed, 2 Mar 2005 18:00:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-ID: <20050303020048.GU15648@holomorphy.com>
References: <200503012129.11840.adobriyan@mail.ru> <20050301134440.05ae1152.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:44:40PM -0800, Andrew Morton wrote:
> Thanks.  Many of these fixups are due to a 64-bit-resource patch in Greg's
> bk-pci tree which he has now reverted.  That being said:
> - That patch will come back sometime
> - Fixes like the below make sense anyway and can be merged any time.
> - All the fixes which were only applicable when the 64-bit-resource patch
>   is present have been sent to Greg for when that patch reemerges.

Well, in isolation it's a C99 initializer cleanup, which is good.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
