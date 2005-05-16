Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVEPNrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVEPNrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEPNqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:46:15 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:48584 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261649AbVEPNpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dr5nHwkeNUOZeOZ3lapiT4lPhuluRwO4/c/aaVpOc1MvF+IWWs21VMya+m5ET6fNYWpiJjDbIEpEzpDrcsFRaK97tF02hBpGmTrZS2Y90I9OVwQw/fgpDvTuVyxmFK3iFDfZM2NPMj/PjKCHCbty0R9Lj+edmA+rW/jGj2M+Plw=
Message-ID: <4ad99e0505051606451ce33b0f@mail.gmail.com>
Date: Mon, 16 May 2005 15:45:38 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: linux <kernel@wired-net.gr>
Subject: Re: 2.6 Kernel Threads
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <002f01c55a1a$7c2cfda0$0101010a@dioxide>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <002f01c55a1a$7c2cfda0$0101010a@dioxide>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, linux <kernel@wired-net.gr> wrote:
> Hi all,
> can u tell how i can start/stop a kernel thread in 2.6.x series kernel???

Kernel threads are used to perform crusal operations in the backgorund
and runs solely in kernel-space so I am not fully aware of why you
would want to start and stop them ?.

Anyway you can spawn a new kernel thread using 

int kernel_thread(int (*fn)(void *), void * arg, unisgned long flags).



Regards.

Lars Roland
