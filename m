Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUANJvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUANJvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:51:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:13256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263636AbUANJrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:47:36 -0500
Date: Wed, 14 Jan 2004 01:47:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-Id: <20040114014748.4bc980f8.akpm@osdl.org>
In-Reply-To: <1074072899.4981.4.camel@laptop.fenrus.com>
References: <20040114090603.GA1935@averell>
	<1074072899.4981.4.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Wed, 2004-01-14 at 10:06, Andi Kleen wrote:
> 
>  > 
>  > According to some gcc developers it should be safe to use in all
>  > gccs that are still supports (2.95 and up) 
> 
>  it is not safe for the kernel until the cardbus CardServices patches get
>  merged (is in -mm), for the same reason CardServices() is broken on
>  amd64.

The CardServices API migration work is complete.  It'll probaby appear in
2.6.2.

