Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTEMNUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEMNUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:20:19 -0400
Received: from corky.net ([212.150.53.130]:18364 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261195AbTEMNUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:20:19 -0400
Date: Tue, 13 May 2003 16:32:58 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305130556_MC3-1-389D-DEBF@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305131336170.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  # rpm --freshen mount-2.11n-12.rpm
>
>
>    swapoff get silently replaced AFAICT.
>

This would also happen with the encrypted swap solution since it
replaces swapon.

Wouldn't it happen on upgrades even if you put it all in the kernel, since
the stock redhat kernel would have it off by default ?  (It will be
off by default because most people won't need this feature and it'll have
a performance penalty) ?

I guess when you maintain a non-default system you must have some
post-upgrade procedure.  I know I do.



