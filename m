Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTIZI4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTIZI4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:56:53 -0400
Received: from trained-monkey.org ([209.217.122.11]:23817 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S262030AbTIZI4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:56:52 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Frank v Waveren <fvw@var.cx>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
References: <20030925160351.E26493@one-eyed-alien.net>
	<20030926052636.GA15006@var.cx> <1064561225.28616.15.camel@gaston>
	<20030926073407.GA15797@var.cx> <1064562042.28617.23.camel@gaston>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 26 Sep 2003 04:56:50 -0400
In-Reply-To: <1064562042.28617.23.camel@gaston>
Message-ID: <m3vfrg0vxp.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Ben> On Fri, 2003-09-26 at 09:34, Frank v Waveren wrote:
>> in[bwl]/out[bwl] are available on a lot more than just x86. Mind
>> you, the mechanisms are subtly different. Then again, if you're
>> using direct hardware access you're not going for portability
>> anyway.

Ben> Are they from userland ? I doubt it...

Actually yes on some architectures, ia64 emulates it the ia32
API. That said, it's certainly not something one should be encouraged
to do, using MMIO is a far better approach.

Cheers,
Jes
