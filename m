Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGGGns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGGGns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVGGGmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:42:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbVGGGmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:42:13 -0400
Date: Wed, 6 Jul 2005 23:41:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: davej@redhat.com, davem@davemloft.net, pmarques@grupopie.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
Message-Id: <20050706234102.2172ca76.akpm@osdl.org>
In-Reply-To: <1120718229.3198.8.camel@laptopd505.fenrus.org>
References: <42CBE97C.2060208@grupopie.com>
	<20050706.125719.08321870.davem@davemloft.net>
	<20050706205315.GC27630@redhat.com>
	<20050706181220.3978d7f6.akpm@osdl.org>
	<1120718229.3198.8.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> > > On Transmeta CPUs that probably triggers a retranslation of
>  > > x86->native bytecode, if it thinks it hasn't seen code at that
>  > > address before.
>  > > 
>  > 
>  > ouch.   What do we do?  Default to off?  Default to off on xmeta?
> 
>  off-on-xmeta would be my preference; I'll cook up a patch for that.

Well we seem to have several people reporting problems of various sorts
with that patch?
