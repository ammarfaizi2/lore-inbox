Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUIGVif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUIGVif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUIGVWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:22:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:59298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268672AbUIGVTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:19:32 -0400
Date: Tue, 7 Sep 2004 14:17:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.9-rc1-mm4
Message-Id: <20040907141741.58174cfd.akpm@osdl.org>
In-Reply-To: <544180000.1094575502@[10.10.2.4]>
References: <544180000.1094575502@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Well, the good news is that it compiles now, and without forcing ACPI on.
>  Yay!

Does it boot?

>  On the downside, it seems to have a new error:
> 
>  make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
> 
>  which appears partway through make install, but only if you do "make -j32",
>  not make -j.

Yes, I get them too, with make -j6(ish).  I used to get tons of these
warnings, but it stopped happening maybe a year ago.  It looks like Sam
found a way to bring it back ;)

