Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUBND3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 22:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUBND3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 22:29:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:45960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264583AbUBND3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 22:29:50 -0500
Date: Fri, 13 Feb 2004 19:30:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximizing and maintaining fragmentation
Message-Id: <20040213193018.339d2095.akpm@osdl.org>
In-Reply-To: <402D2687.2000005@techsource.com>
References: <402D2687.2000005@techsource.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> wrote:
>
> IMPORTANT QUESTION:  When writing to an mmap'ed file, will ext3 
>  rearrange blocks on disk in order to reduce fragmentation, or will it 
>  leave the blocks exactly where they are, just overwriting the data?

The blocks will not change.
