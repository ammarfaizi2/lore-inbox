Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWGETWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWGETWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWGETWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:22:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964998AbWGETWs (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:22:48 -0400
Date: Wed, 5 Jul 2006 12:26:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: reiser@namesys.com, hch@infradead.org, Linux-Kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-Id: <20060705122615.3a4fca06.akpm@osdl.org>
In-Reply-To: <1152117935.6337.48.camel@tribesman.namesys.com>
References: <44A42750.5020807@namesys.com>
	<20060629185017.8866f95e.akpm@osdl.org>
	<1152011576.6454.36.camel@tribesman.namesys.com>
	<20060704114836.GA1344@infradead.org>
	<44AAA8ED.5030906@namesys.com>
	<20060704151832.9f2d87b3.akpm@osdl.org>
	<1152117935.6337.48.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vladimir V. Saveliev" <vs@namesys.com> wrote:
>
> This patch adds a method batch_write to struct address_space_operations.
> A filesystem may want to implement this operation to improve write performance.

I failed to make a record of which other filesystems will want to use this.
Do you recall?
