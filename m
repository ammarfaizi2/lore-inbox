Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbTGLE2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 00:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbTGLE2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 00:28:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267557AbTGLE2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 00:28:39 -0400
Date: Fri, 11 Jul 2003 21:34:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IPV6 warnings in 2.4.22-pre4
Message-Id: <20030711213438.4a9aba97.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0307111434400.8989-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307111434400.8989-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003 14:38:29 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> 
> When compiling 2.4.22-pre4 for m68k, I see these suspicious warnings:
> 
> | ip6t_rt.c:134: warning: assignment from incompatible pointer type
> | ip6t_ipv6header.c:43: warning: unused variable `opt'
> | ip6t_frag.c:151: warning: assignment from incompatible pointer type
> | ip6t_esp.c:127: warning: assignment from incompatible pointer type
> | ip6t_ah.c:137: warning: assignment from incompatible pointer type

They turn out to be harmless but I'll fix them up.
Thanks for the report.
