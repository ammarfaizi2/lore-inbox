Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTFPWqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTFPWqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:46:20 -0400
Received: from main.gmane.org ([80.91.224.249]:61122 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264432AbTFPWqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:46:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.5.71 compile error on alpha
Date: 17 Jun 2003 01:00:01 +0200
Message-ID: <yw1xhe6pzkzy.fsf@zaphod.guide>
References: <3EEE4A14.4090505@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> writes:

> i have an alpha here, running 2.5.70 for weeks now. the patch to 2.5.71
> applied with no errors (i did "make clean" before this) but it won't
> compile:
> 
> # make vmlinux modules modules_install
> 
> ...
> 
>    CC      arch/alpha/kernel/srmcons.o
> arch/alpha/kernel/srmcons.c:269: warning: `srmcons_ops' defined but not used
> make[2]: *** [arch/alpha/kernel/srmcons.o] Error 1
> make[1]: *** [arch/alpha/kernel] Error 2
> make: *** [vmlinux] Error 2

Not looking at the code, I guess you could just remove the definition
of srmcons_ops from srmcons.c.

-- 
Måns Rullgård
mru@users.sf.net

