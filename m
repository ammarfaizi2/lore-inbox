Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbUBGTFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267062AbUBGTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:05:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:49327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267058AbUBGTFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:05:18 -0500
Date: Sat, 7 Feb 2004 11:07:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-Id: <20040207110732.4c6ced3f.akpm@osdl.org>
In-Reply-To: <20040207090634.GQ19011@krispykreme>
References: <20040207042559.GP19011@krispykreme>
	<20040206210428.17ee63db.akpm@osdl.org>
	<20040207090634.GQ19011@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  > Should this not search for the emptiest node?
> 
>  Allocating things round robin avoids a hot node where everything ends up
>  being allocated.

Have you any performance measurements for this patch?

>  > Is non-__init code allowed to call __init code?  I thought that caused
>  > linkage errors on some setups.  Pretty sure about that.  I think, maybe.
> 
>  Maybe. Its news to me.

I'll check.

