Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUJOBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUJOBbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJOBbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:31:39 -0400
Received: from ozlabs.org ([203.10.76.45]:15581 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267986AbUJOBbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:31:31 -0400
Subject: Re: faster via/centaur hw rng throughput patch for 2.6.8.1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Peck <coderman@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4ef5fec604082711523b3935f9@mail.gmail.com>
References: <4ef5fec604082711523b3935f9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097803902.22673.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:31:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 04:52, Martin Peck wrote:
> - module parameters are used to specify configuration of
>   the entropy sources

Please use the new-style module_param() macros (in module_param.h)
rather than the deprecated MODULE_PARM macro.  The new ones are typesafe
and more flexible, and the old ones are going away...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

