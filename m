Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUDOViJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUDOViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:38:09 -0400
Received: from [62.241.33.80] ([62.241.33.80]:54546 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262132AbUDOViH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:38:07 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH] Kconfig.debug family
Date: Thu, 15 Apr 2004 23:36:30 +0200
User-Agent: KMail/1.6.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Matt Mackall <mpm@selenic.com>,
       jgarzik@pobox.com, akpm@osdl.org
References: <407CEB91.1080503@pobox.com> <20040414212539.GE1175@waste.org> <20040415135229.75964100.rddunlap@osdl.org>
In-Reply-To: <20040415135229.75964100.rddunlap@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404152336.30621@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 22:52, Randy.Dunlap wrote:

Hi Randy,

> This patch:
> - creates lib/Kconfig.debug for generic kernel debug options
> - creates arch/*/Kconfig.debug for arch-specific debug options
> - moves KALLSYMS to the generic kernel debug options list
> This is a first cut for review/comments.  I will double-check
> the generic options list to see how it needs to be corrected...

I really appreciate it. But I have one comment/suggestion:

We might use lib/Kconfig.debug for all arches and use proper "depend on" if 
there is stuff for some specific arch only. So we have every debug stuff just 
in one file. What do you think?

ciao, Marc
