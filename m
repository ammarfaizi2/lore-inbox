Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWHHVKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWHHVKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWHHVKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:10:06 -0400
Received: from xenotime.net ([66.160.160.81]:224 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965032AbWHHVKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:10:04 -0400
Date: Tue, 8 Aug 2006 14:12:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still get build warnings - gcc-3.4.6 - 2.6.17.8
Message-Id: <20060808141246.25ee5db7.rdunlap@xenotime.net>
In-Reply-To: <200608082148.11433.nick@linicks.net>
References: <200608082148.11433.nick@linicks.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 21:48:11 +0100 Nick Warne wrote:

> Hi all,
> 
> I have had these warnings for ages:
> 
> kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
> kernel/power/pm.c:64)
> kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
> kernel/power/pm.c:64)
> kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
> kernel/power/pm.c:97)
> kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
> kernel/power/pm.c:97)
> kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
> kernel/power/pm.c:216)
> kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
> kernel/power/pm.c:216)
> 
> and I think at one time there was a fix about that I applied, but it seems it 
> never made it into kernel.org.
> 
> Or is this my ggc problem?

It's not a gcc (nor ggc) problem.  Those functions are just deprecated.
Current 2.6.18-rc4 and 2.6.18-rc3-mm2 still have those same warnings.

fwiw, I don't seem to have any patches to fix/remove them.

---
~Randy
