Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTDMFjR (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 01:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbTDMFjR (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 01:39:17 -0400
Received: from rth.ninka.net ([216.101.162.244]:44678 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263323AbTDMFjQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 01:39:16 -0400
Subject: Re: >=2.5.66 compiling errors on Alpha
From: "David S. Miller" <davem@redhat.com>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E98117F.8090705@g-house.de>
References: <3E98117F.8090705@g-house.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050213058.15082.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Apr 2003 22:50:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 06:15, Christian wrote:
> do you need further infos to debug this?
> compiling a kernel on this machine is very slow, i think i can't take 
> the "BUG-HUNTING" approach.

The Alpha folks need to fix their definition of cond_syscall().
Copying over the asm-i386/*.h definition will probably "just work".

-- 
David S. Miller <davem@redhat.com>
