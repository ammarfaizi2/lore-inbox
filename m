Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUBIVWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 16:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUBIVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 16:22:17 -0500
Received: from mail.zmailer.org ([62.78.96.67]:19936 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261877AbUBIVWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 16:22:16 -0500
Date: Mon, 9 Feb 2004 23:22:02 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alexandr Chernyy <nikalex@hotbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (no subject)
Message-ID: <20040209212202.GF13308@mea-ext.zmailer.org>
References: <4027F636.6090806@hotbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4027F636.6090806@hotbox.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 11:05:58PM +0200, Alexandr Chernyy wrote:
> Hello All! Can you help me! I write module for kernel 2.4.22 and have 
> some problems! I need to read some information form file, create 
> directory and etc. (Did kerlen have some stdio.h like function - fopen, 
> fgets, fclose......)!!! Please help me.

  Programming in kernel-space isn't at all the same as in userspace.
  For starters, the context stack is highly restricted in size.

  You can have some pointers for it by studying the way, how
  the kernel-space NFS server works while opening files, and
  doing IO.

  Oh yes, there is NO STDIO in kernel.

> WBR, Alexandr Chernyy
> nikalex@sp.mk.ua

/Matti Aarnio
