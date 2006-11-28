Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935062AbWK1DhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935062AbWK1DhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 22:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935067AbWK1DhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 22:37:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935062AbWK1DhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 22:37:01 -0500
Date: Mon, 27 Nov 2006 19:33:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill net/rxrpc/rxrpc_syms.c
Message-Id: <20061127193313.d59f61f0.akpm@osdl.org>
In-Reply-To: <30354.1164626485@redhat.com>
References: <20061126040416.GH15364@stusta.de>
	<30354.1164626485@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 11:21:25 +0000
David Howells <dhowells@redhat.com> wrote:

> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the 
> > files with the actual functions.
> 
> You can if you like.  Can you slap a blank line before each EXPORT_SYMBOL()
> though please?

We have a mixture of both styles and given that they waste space in return
for no added value, people have been gradually removing these blank lines
in many places.  Please don't add more.

