Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWAQIVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAQIVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWAQIVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:21:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932323AbWAQIVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:21:03 -0500
Date: Tue, 17 Jan 2006 00:20:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mita@miraclelinux.com, Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-Id: <20060117002026.24ee50b4.akpm@osdl.org>
In-Reply-To: <20060117075841.GA5710@redhat.com>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com>
	<20060116224234.5a7ca488.akpm@osdl.org>
	<20060117075841.GA5710@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Mon, Jan 16, 2006 at 10:42:34PM -0800, Andrew Morton wrote:
> 
>  > Presumably this is going to bust ksymoops.
>  
> Do people actually still use ksymoops for 2.6 kernels ?

They do if they've disabled kallsyms...

>
> What other tools parse oopses ? ksymoops is the only one I recall.
> 

Embedded systems dink with the output, log it to nvram, etc.  Custom stuff.

I think we can live with the breakage, but let's get Keith's input.
