Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTH0Oi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTH0Oi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:38:29 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43424 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263387AbTH0Oi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:38:28 -0400
Subject: Re: [PATCH] 2.4: always_inline for gcc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826162454.GE2023@werewolf.able.es>
References: <Pine.LNX.4.44.0308260850170.3191@logos.cnet>
	 <20030826162454.GE2023@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061995054.22721.31.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 15:37:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-26 at 17:24, J.A. Magallon wrote:
> gcc3 did not inline big functions, even if they were marked as inline
> Thread:
> http://marc.theaimsgroup.com/?t=103632325600005&r=1&w=2
> Things like memcpy and copy_to/from_user were affected.
> They were not inlined and you got tons of instances in vmlinux.

The more interesting question you want to answer first is - was
gcc right. Repeated code is bad for cache

