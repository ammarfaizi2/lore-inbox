Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLKRWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLKRWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLKRWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:22:36 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:59869 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750756AbVLKRWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:22:36 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch -mm] fix SLOB on x64
Date: Sun, 11 Dec 2005 12:22:54 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
References: <20051211141217.GA5912@elte.hu>
In-Reply-To: <20051211141217.GA5912@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111222.56067.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 09:12, Ingo Molnar wrote:
> this patch fixes 32-bitness bugs in mm/slob.c. Successfully booted x64 
> with SLOB enabled. (i have switched the PREEMPT_RT feature to use the 
> SLOB allocator exclusively, so it must work on all platforms)

Its a good idea to get this working everywhere.  Why have you switched to 
use SLOB exclusively?

Thanks
Ed Tomlinson
