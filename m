Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVCCJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVCCJab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVCCJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:30:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:4511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVCCJ27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:28:59 -0500
Date: Thu, 3 Mar 2005 01:28:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, linuxram@us.ibm.com, slpratt@austin.ibm.com
Subject: Re: [PATCH 1/2] readahead: simplify ra->size testing
Message-Id: <20050303012831.058154c0.akpm@osdl.org>
In-Reply-To: <4226E22A.2526DE09@tv-sign.ru>
References: <42260F2C.FCAA1915@tv-sign.ru>
	<20050302175947.6f1e6b5f.akpm@osdl.org>
	<4226E22A.2526DE09@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Andrew Morton wrote:
>  > 
>  > So...  the big "how it all works" comment needs an update..
> 
>  Same patch, comment updated.

Thanks, is nice.

But I actually meant this comment, from readahead.c:

 *
 * When readahead is in the off state (size == -1UL), readahead is disabled.
 * In this state, prev_page is used to detect the resumption of sequential I/O.
 *

