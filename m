Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVCBN0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVCBN0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVCBN0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:26:14 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:51485 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262286AbVCBN0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:26:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=A3d0B5dC4olfPJVMjKU/i9l9a3wz1xklyemNG7l7QwgSFHLfi/lHhdXkLqOZysCP4co8QzO7CJgoLXNlp8a6HYdYP1IcXFwVz7pl6bVhM/Ddu+ADt2ZmJRO7SKyR49poR5XYyM0Wc6xzTrzVaMTInKOPCoGcIxWemfNwv70wYb4=
Message-ID: <65258a58050302052661e856c6@mail.gmail.com>
Date: Wed, 2 Mar 2005 14:26:11 +0100
From: Vincent Vanackere <vincent.vanackere@gmail.com>
Reply-To: Vincent Vanackere <vincent.vanackere@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Cc: keenanpepper@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050302032414.13604e41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422550FC.9090906@gmail.com>
	 <20050302012331.746bf9cb.akpm@osdl.org>
	 <65258a58050302014546011988@mail.gmail.com>
	 <20050302032414.13604e41.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works fine for me now, thanks !

Vincent

On Wed, 2 Mar 2005 03:24:14 -0800, Andrew Morton <akpm@osdl.org> wrote:

> OK, there are no vmlinux references to lib/parser.o's symbols.  So it isn't
> getting linked in.
> 
> In lib/Makefile, remove parser.o from the lib-y: rule and add
> 
> obj-y   += parser.o
