Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271531AbTGQVIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271532AbTGQVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:08:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:2502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271531AbTGQVIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:08:47 -0400
Date: Thu, 17 Jul 2003 14:16:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: george@mvista.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
Subject: Re: do_div64 generic
Message-Id: <20030717141608.5f1b7710.akpm@osdl.org>
In-Reply-To: <200307172310.48918.bernie@develer.com>
References: <3F1360F4.2040602@mvista.com>
	<3F149747.3090107@mvista.com>
	<200307162033.34242.bernie@develer.com>
	<200307172310.48918.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
> 2) replace all uses of div_long_long_rem() (I see onlt 4 of them in
>    2.6.0-test1) with do_div(). This is slightly less efficient, but
>    easier to maintain in the long term.

Ths one's OK by me.  Let's just fix the bug with minimum risk and churn.
