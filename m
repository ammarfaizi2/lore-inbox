Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUAUX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUAUX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:27:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:12999 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266184AbUAUX1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:27:20 -0500
Date: Wed, 21 Jan 2004 15:28:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixes for 2.6.1-rc2-mm1 on PPC
Message-Id: <20040121152841.1972a613.akpm@osdl.org>
In-Reply-To: <16399.2355.817325.605721@cargo.ozlabs.ibm.com>
References: <16399.2355.817325.605721@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew,
> 
> This patch is needed to get 2.6.1-rc2-mm1 to compile and work on PPC.
> It looks like Ingo (or someone) made changes to the discontiguous file
> mapping stuff for x86 and didn't make the corresponding changes for
> other archs, so this patch makes the changes for PPC.

Sweet, thanks.  I subsequently dropped those patches due to crashiness in
one of them.  But I see a new version in my inbox.

> I'll do PPC64 as well shortly.

Also much appreciated.  Breaking everything !x86 distresses me.


