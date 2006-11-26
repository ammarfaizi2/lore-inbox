Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935219AbWKZAp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935219AbWKZAp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 19:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935218AbWKZAp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 19:45:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935213AbWKZApT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 19:45:19 -0500
Date: Sat, 25 Nov 2006 16:41:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
Message-Id: <20061125164118.de53d1cf.akpm@osdl.org>
In-Reply-To: <adak61j5djh.fsf@cisco.com>
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<adak61j5djh.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 15:09:38 -0800
Roland Dreier <rdreier@cisco.com> wrote:

>  > But yes, given the array sizing case in the neighbour code,
>  > perhaps we can use your original patch for now.  Feel free
>  > to push that to Linus.
> 
> akpm is CC'ed on this thread.  Andrew, are you going to pick this up?

Changes this late in the piece rather hurt.

Your proposed change is still wrong for long longs, isn't it?
