Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUJKMMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUJKMMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJKMMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:12:01 -0400
Received: from colin2.muc.de ([193.149.48.15]:60429 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268854AbUJKMLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:11:53 -0400
Date: 11 Oct 2004 14:11:51 +0200
Date: Mon, 11 Oct 2004 14:11:51 +0200
From: Andi Kleen <ak@muc.de>
To: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Cc: Hideo AOKI <aoki@sdl.hitachi.co.jp>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
Message-ID: <20041011121151.GB82428@muc.de>
References: <2LXI2-3a5-21@gated-at.bofh.it> <m3ekkd46a8.fsf@averell.firstfloor.org> <4163E2C0.5050109@sdl.hitachi.co.jp> <20041006155000.46c9acdc.akpm@osdl.org> <416549CE.2070202@sdl.hitachi.co.jp> <1097483998.16118.14.camel@libra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097483998.16118.14.camel@libra>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 04:39:58PM +0800, Wen-chien Jesse Sung wrote:
> Hi,
> 
> In  include/linux/sysctl.h  of 2.6.9-rc3-mm3, both VM_HEAP_STACK_GAP and
> VM_SWAP_TOKEN_TIMEOUT are 28. Maybe one of them should be 29?

It doesn't really matter much anymore because the numerical sysctl
values are deprecated. Everybody should use the names in 
/proc/sys instead. Hopefully they will eventually go away completely
and avoid a lot of patch conflicts.

-Andi

