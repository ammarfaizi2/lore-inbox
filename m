Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUJFD5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUJFD5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUJFD5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:57:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:36783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266838AbUJFD5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:57:13 -0400
Date: Tue, 5 Oct 2004 20:55:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041005205511.7746625f.akpm@osdl.org>
In-Reply-To: <200410060042.i960gn631637@unix-os.sc.intel.com>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> This value was default to 10ms before domain scheduler, why does domain
>  scheduler need to change it to 2.5ms? And on what bases does that decision
>  take place?  We are proposing change that number back to 10ms.

It sounds like this needs to be runtime tunable?
