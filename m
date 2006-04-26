Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWDZSoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWDZSoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWDZSoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:44:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750883AbWDZSoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:44:22 -0400
Date: Wed, 26 Apr 2006 11:46:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-Id: <20060426114649.5a0e0dea.akpm@osdl.org>
In-Reply-To: <20060426182323.GI5002@suse.de>
References: <20060426135310.GB5083@suse.de>
	<20060426095511.0cc7a3f9.akpm@osdl.org>
	<20060426174235.GC5002@suse.de>
	<20060426111054.2b4f1736.akpm@osdl.org>
	<20060426182323.GI5002@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Are there cases where the lockless page cache performs worse than the
> current one?

Yeah - when human beings try to understand and maintain it.

The usual tradeoffs apply ;)
