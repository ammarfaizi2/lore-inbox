Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWHTDbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWHTDbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 23:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWHTDbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 23:31:13 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:20647 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751641AbWHTDbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 23:31:12 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: Linux 2.4.33.1
Date: Sun, 20 Aug 2006 13:31:06 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <nklfe2pa091vb1idddjbfrvplk5jddcfam@4ax.com>
References: <20060819141355.GA6302@hera.kernel.org>
In-Reply-To: <20060819141355.GA6302@hera.kernel.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 14:13:55 +0000, Willy Tarreau <wtarreau@hera.kernel.org> wrote:

>Hi !
>
>As there were a few security fixes pending and 2.4.34-pre1 has not
>received enough validation, I've released 2.4.33.1 ...

Needed this to not confuse existing slackware-10.2 startup script:

--- linux-2.4.33.1/Makefile     2006-08-20 08:33:27.000000000 +1000
+++ linux-2.4.33-1/Makefile     2006-08-20 12:50:28.000000000 +1000
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 33
-EXTRAVERSION = .1
+EXTRAVERSION = -1

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

Looks like 2.6 like stable naming convention not gonna fly for 2.4?

Grant.
