Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUHAIHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUHAIHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 04:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUHAIHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 04:07:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:60128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265490AbUHAIHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 04:07:02 -0400
Date: Sun, 1 Aug 2004 01:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040801010532.37966eda.akpm@osdl.org>
In-Reply-To: <20040801023655.GN2334@holomorphy.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	<20040801023655.GN2334@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/
> [...]
> 
> There's trouble here with the link checking; it pukes all over
> sparc32's btfixup stuff. Not entirely sure what the proper form of a
> solution is.
> 

Do you mean the "check vmlinux for undefined symbols" thing?

That's proving to be a royal pain, although rmk's arguments for needing it
are good.  Could you find a way of fixing it up?
