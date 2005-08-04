Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVHDUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVHDUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVHDUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:13:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262656AbVHDUN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:13:27 -0400
Date: Thu, 4 Aug 2005 13:15:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: x86_64 access of some bad address
Message-Id: <20050804131512.7d464fad.akpm@osdl.org>
In-Reply-To: <1119539630.1170.6.camel@localhost.localdomain>
References: <1119539630.1170.6.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> As I only have one x86_64 which is my main workstation it's far too
> tedious to do binary searching (this doesn't happen on x86).
> 
> Happens with both latest -git and 2.6.12-mm1
> The tools to reproduce this is at: http://serkiaden.mine.nu/kp2.tar
> 
> Just do:
> gdb lyze
> run
> 
> and it crashes here giving:
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at "mm/memory.c":911

So I think Hugh's patch this morning should fix this up.  Please retest
-rc6 when it's out?
