Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVHEA3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVHEA3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbVHEA3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:29:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262797AbVHEA3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:29:07 -0400
Date: Thu, 4 Aug 2005 17:30:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: marcel@holtmann.org, rml@tech9.net, linux@dominikbrodowski.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-git4: bluetooth oops on pcmcia shutdown
Message-Id: <20050804173055.17088973.akpm@osdl.org>
In-Reply-To: <42EEA8E9.5090107@domdv.de>
References: <42EEA8E9.5090107@domdv.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> The attached bluetooth oops can be reliably reproduced on my x86_64
> laptop. It happens when hciattach is still running while a sequence of
> "cardctl eject" and then "killproc /sbin/cardmgr" is executed.
> Though this seems to point to preempt I could manage to cause similar
> oopses on non-preemptible kernels a while ago.

Again, it doesn't look like we'll have a quick fix for this, so a bugzilla
entry would be appreciated, please.

It would help if you can identify an earlier 2.6 kernel which didn't have
the bug, thanks.
