Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUECCRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUECCRK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUECCRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:17:10 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:56983 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263467AbUECCRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:17:07 -0400
Subject: Re: query_module in 2.6
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Pinyowattayakorn, Naris" <np151003@teradata-ncr.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01B69E0E615FD5118EA00003477144BA1082B917@susdayte52.daytonoh.ncr.com>
References: <01B69E0E615FD5118EA00003477144BA1082B917@susdayte52.daytonoh.ncr.com>
Content-Type: text/plain
Message-Id: <1083545486.25582.51.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 12:16:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 13:24, Pinyowattayakorn, Naris wrote:
> Hi,
> 
> I tried to search for posts regarding to the query_module but came up empty.
> It seems to me that the sys_query_module call was removed from the 2.6
> kernel. So the question I have is if there any alternative way to get the
> kernel module symbols in 2.6. Or, I'm missing something here?

You shouldn't need to.  But for debugging, you can use /proc/kallsyms.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

