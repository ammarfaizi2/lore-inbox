Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGGQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGGQYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWGGQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:24:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:32715 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932181AbWGGQYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:24:52 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO bitmaps
Date: Fri, 7 Jul 2006 18:22:12 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607071155_MC3-1-C45F-B7C2@compuserve.com>
In-Reply-To: <200607071155_MC3-1-C45F-B7C2@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607071822.12495.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 July 2006 17:53, Chuck Ebbert wrote:

>  
> -static inline void
> -handle_io_bitmap(struct thread_struct *next, struct tss_struct *tss)
> +static inline void __switch_to_xtra(struct task_struct *next_p,
> +				    struct tss_struct *tss)

I would make that noinline


Rest looks good
-Andi
