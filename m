Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUHBQQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUHBQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUHBQQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:16:58 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:17848 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266595AbUHBQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:16:56 -0400
Message-ID: <20040802161656.32244.qmail@web14922.mail.yahoo.com>
Date: Mon, 2 Aug 2004 09:16:56 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: OLS and console rearchitecture
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <410E55AA.8030709@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
> Jon Smirl wrote:
> > 15) Over time user space console will be moved to a model where
> 
> One more minor problem. We need to ensure somehow that the "killall5"
> program from the sysvinit package will not kill our userspace console
> daemon at shutdown (got this when I tried to put fbiterm into 
> initramfs). What is the best way to achieve that?

When user space dies on shutdown output would switch over to the kernel
based console - the reverse process of what happens on start up. Do we
need more?

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
