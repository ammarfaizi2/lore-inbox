Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWELJPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWELJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWELJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:15:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53379 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751093AbWELJPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:15:07 -0400
Date: Fri, 12 May 2006 11:14:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
Message-ID: <20060512091451.GA18145@elte.hu>
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> -#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> +#define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
