Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbTKXJsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTKXJsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:48:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6674 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S263703AbTKXJsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:48:41 -0500
Date: Mon, 24 Nov 2003 10:48:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
       hpa@zytor.com
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031124094838.GA24798@alpha.home.local>
References: <20031124051910.GA2766@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124051910.GA2766@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 09:19:10PM -0800, Larry McVoy wrote:

> Unable to handle kernel paging request at virtual address 4954507d
> eax: 00000000   ebx: 49545055   ecx: 0000000f   edx: c1640000

Here, EBX is pure text : "UPTI", as in "CORRUPTION" or "INTERRUPTIBLE". May be
there has been some memory corruption somewhere in a linked list ?

Cheers,
Willy

