Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992525AbWJTG5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992525AbWJTG5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992524AbWJTG5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:57:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946253AbWJTG5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:57:23 -0400
Date: Thu, 19 Oct 2006 23:57:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] netpoll/netconsole fixes
Message-Id: <20061019235719.5b30c5d3.akpm@osdl.org>
In-Reply-To: <20061019171541.062261760@osdl.org>
References: <20061019171541.062261760@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 10:15:41 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The netpoll transmit skb management is a mess, it has two
> paths and it's on Txq. These patches try and clean this up.
> 

I got a reject storm when applying the third patch then screwed it up
rather than fixing it up.

A rediff and resend is needed, please.  Make sure it's against the latest
-linus or -davem, thanks.

