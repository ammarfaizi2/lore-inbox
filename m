Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUCZXrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUCZXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:47:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:59031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261455AbUCZXrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:47:45 -0500
Date: Fri, 26 Mar 2004 15:49:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-Id: <20040326154955.65d40a3e.akpm@osdl.org>
In-Reply-To: <4064B8B1.6050501@blueyonder.co.uk>
References: <4062E015.2000608@blueyonder.co.uk>
	<40633278.9060503@blueyonder.co.uk>
	<4064B8B1.6050501@blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> >> arch/x86_64/kernel/signal.c: In function `do_signal':
> >> arch/x86_64/kernel/signal.c:426: warning: passing arg 2 of 
> >> `get_signal_to_deliver' from incompatible poi
> >> nter type
> >> arch/x86_64/kernel/signal.c:426: error: too few arguments to function 
> >> `get_signal_to_deliver'
> >> make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
> >> make: *** [arch/x86_64/kernel] Error 2

You'll need to revert signal-race-fix.patch until the various arch guys
catch up.

