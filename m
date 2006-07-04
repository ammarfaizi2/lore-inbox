Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWGDGui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWGDGui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWGDGui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:50:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbWGDGuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:50:37 -0400
Date: Mon, 3 Jul 2006 23:50:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Ubuntu PATCH] fix VFS nr_files accounting
Message-Id: <20060703235031.0fe17c18.akpm@osdl.org>
In-Reply-To: <44A98241.2040705@oracle.com>
References: <44A98241.2040705@oracle.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 13:46:57 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> 
> lkml discussion: http://thread.gmane.org/gmane.linux.kernel/385438/focus=385478
> 
> Already in -mm?
> 
> From: Dipankar Sarma <dipankar@in.ibm.com>
> 
> Ubuntu patch location:
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=5ce2ed3a63172c6ce0b97069e449960c2d538623
> 

hm.  This is actually a reversion of
529bf6be5c04f2e869d07bfdb122e9fd98ade714, so it presumably reintroduces the
problem discussed in that lkml thread.

Ben, what's the story here?

Thanks.
