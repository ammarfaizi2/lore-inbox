Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHMG07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHMG07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWHMG07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:26:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750714AbWHMG07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:26:59 -0400
Date: Sat, 12 Aug 2006 23:26:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [108/145] x86_64: Some preparationary
 cleanup for stack trace
Message-Id: <20060812232645.6ae8121c.akpm@osdl.org>
In-Reply-To: <20060810193706.8DDA613C0B@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193706.8DDA613C0B@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:37:06 +0200 (CEST)
Andi Kleen <ak@suse.de> wrote:

> - Remove unused all_contexts parameter 
> No caller used it

s390 does and now it's busted.
