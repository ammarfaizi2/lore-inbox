Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWCTLNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWCTLNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWCTLNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:13:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750729AbWCTLNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:13:54 -0500
Date: Mon, 20 Mar 2006 03:10:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: prasanna@in.ibm.com
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-Id: <20060320031017.23d8a9b1.akpm@osdl.org>
In-Reply-To: <20060320061014.GE31091@in.ibm.com>
References: <20060320060745.GC31091@in.ibm.com>
	<20060320060931.GD31091@in.ibm.com>
	<20060320061014.GE31091@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> +/**
>  + *  This function hooks the readpages() of all modules that have active
>  + *  probes on them. The original readpages() is called for the given
>  + *  inode/address_space to actually read the pages into the memory.
>  + *  Then all probes that are specified on these pages are inserted.
>  + */

The "/**" thing is designed to introduce a kerneldoc-style comment, but
these comments aren't using kerneldoc.

