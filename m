Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUEQWch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUEQWch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUEQWcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:32:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:15277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263040AbUEQWbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:31:35 -0400
Date: Mon, 17 May 2004 15:34:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert behaviour of pty allocation in 2.6
Message-Id: <20040517153411.5c5cb81b.akpm@osdl.org>
In-Reply-To: <1084810491.2155.24.camel@alpha.digital-domain.net>
References: <1084810491.2155.24.camel@alpha.digital-domain.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clayton <andrew@digital-domain.net> wrote:
>
> Here is a patch which is mainly 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm5/broken-out/pty-allocation-first-fit.patch
> 
> with a couple of changes.
> 
> That patch didn't quite work....

aargh, that stoopid counter in the top eight bits of the idr_get_new return value :(.  Thanks.

