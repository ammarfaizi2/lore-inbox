Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUHMR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUHMR5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHMR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:57:48 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:21483 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S266303AbUHMRyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:54:23 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <andrea@suse.de>
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
Date: Fri, 13 Aug 2004 19:53:28 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20040813162018.GB29292@logos.cnet>
Thread-Index: AcSBXNVfND0QWvTzQzCtcZaoirqOOQAAHK4w
Message-Id: <20040813175422.0D0162FC2C@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcello,

> v2.6 is much better improved in that area.

Unfortunately, I'm stuck with Debian woody release for now and testing v2.6
could be a pain for us. I'll check again what I can do for this ...


> It might be that you are hitting the deadlock which the following patch
> fixes.

I saw it in a previous thread but was not sure it was related to my problem.
I was on my way to test it anyway !


> You're not able to get sysrq output on the console? It will help if you
> can
> plug a serial cable and use try to get sysrq output (SysRQ+T
> and SysRQ+P). Have you tried the sysrq thing?

When the server was hung, we were not able to get anything, but I'll try
again (just to check we were using the good keystrokes ;-)


> I'm willing to help and track it down.

Thanks.

> You want to try this
> ...[snip]...

I'll let you know asap. I don't think I'll be able to reboot the server from
home this weekend. At least, I'll prepare a new kernel with the patch and
install it on Monday morning.

Regards,
Sylvain.

