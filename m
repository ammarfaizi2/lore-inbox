Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275116AbTHGGnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275117AbTHGGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:43:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:62429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275116AbTHGGnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:43:11 -0400
Date: Wed, 6 Aug 2003 23:44:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-Id: <20030806234457.5ca9e5af.akpm@osdl.org>
In-Reply-To: <20030807063311.GX32488@holomorphy.com>
References: <20030806223716.26af3255.akpm@osdl.org>
	<20030807063311.GX32488@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>  Looks like this got backed out when vmlinux.lds.S moved:
> 

yes it did, thanks.

>  --- linux-old/arch/i386/kernel/vmlinux.lds.S	2003-08-06 23:23:53.000000000 -0700
>  +++ linux-new/arch/i386/kernel/vmlinux.lds.S	2003-08-04 15:02:26.000000000 -0700

Yes, that change is needed for building with the 4g/4g split.
