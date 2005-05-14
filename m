Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVENI44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVENI44 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 04:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVENI44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 04:56:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:11728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262710AbVENI4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 04:56:54 -0400
Date: Sat, 14 May 2005 01:56:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirk True <kernel@kirkandsheila.com>
Cc: linux-kernel@vger.kernel.org, Ray Bryant <raybry@sgi.com>
Subject: Re: [PATCH] Remove unused CONFIG_LOCKMETER functions
Message-Id: <20050514015611.586f0a9f.akpm@osdl.org>
In-Reply-To: <1116057474.7432.4.camel@itchy.kirkandsheila.com>
References: <1116057474.7432.4.camel@itchy.kirkandsheila.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk True <kernel@kirkandsheila.com> wrote:
>

(Please wrap your emails to < 80 columns)

> I'm working on porting SGI's lockmeter to 2.6 when I chanced upon this. I was very perplexed that it's in there since this is the only place that it appears in the codebase (according to grep).

Ray Bryant (cc'ed here) probably has a mostly-up-to-date lockmeter patch.  It
would be better to work starting from that.

>          Signed-off-by: Kirk True <kirk@kirkandsheila.com>
> 
>  diff -urpN linux-2.6.11.9/include/linux/spinlock.h

You should work against the development kernel.  We've added 22MB of diff
since 2.6.11.

