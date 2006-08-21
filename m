Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWHUOra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWHUOra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWHUOra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:47:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30648 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030516AbWHUOr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:47:29 -0400
Date: Mon, 21 Aug 2006 10:46:57 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Magnus Damm <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Message-ID: <20060821144657.GE9549@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com> <20060821141721.GA29498@in.ibm.com> <200608211624.11005.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608211624.11005.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 04:24:10PM +0200, Andi Kleen wrote:
> 
> > Given the idea of relocatable kernel is floating around I would prefer if
> > we are not bounded by the restriction of loading a kernel in lowest 4G.
> 
> There is already other code that requires this. In fact i don't think it can
> be above 40MB currently.
>

But I think Eric's prototype patches for relocatable kernel do get over
this limitation (Hope I understood the code right). Assuming that relocatable
kernel patches will be merged down the line, it would be nice not to be
bound by 4G limitation.

Thanks
Vivek

