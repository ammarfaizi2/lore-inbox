Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVLTT2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVLTT2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVLTT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:28:44 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50816 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750967AbVLTT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:28:44 -0500
Subject: Re: 2.6.15-rc5-rt4 x86 patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1135100583.3415.16.camel@localhost.localdomain>
References: <1135100583.3415.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 14:28:31 -0500
Message-Id: <1135106911.13138.343.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

I've submitted a similar patch since rc5-rt1.

http://lkml.org/lkml/2005/12/13/184

Ingo,

It's still not in there?

-- Steve


On Tue, 2005-12-20 at 11:43 -0600, Clark Williams wrote:
> I still need the following to compile with PREEMPT_RT on an x86:
> 
> --- ./arch/i386/Kconfig.cpu.orig        2005-12-20 11:26:34.000000000 -0600
> +++ ./arch/i386/Kconfig.cpu     2005-12-20 11:33:23.000000000 -0600
> @@ -229,11 +229,6 @@
>         depends on M386
>         default y
> 
> -config RWSEM_XCHGADD_ALGORITHM
> -       bool
> -       depends on !M386
> -       default y
> -
>  config GENERIC_CALIBRATE_DELAY
>         bool
>         default y


