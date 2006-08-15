Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWHOKsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHOKsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWHOKsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:48:33 -0400
Received: from ns.suse.de ([195.135.220.2]:12212 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030193AbWHOKsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:48:32 -0400
Date: Tue, 15 Aug 2006 12:48:00 +0200
From: Andi Kleen <ak@muc.de>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for review] [127/145] i386: move kernel_thread_helper
 into entry.S
Message-Id: <20060815124800.09a84445.ak@muc.de>
In-Reply-To: <44E1BFDC.76E4.0078.0@novell.com>
References: <44E1BFDC.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 12:36:44 +0200
"Jan Beulich" <jbeulich@novell.com> wrote:

> Just like done in the x86-64 patch that I just sent, I'd recommend
> moving
> the push added yesterday outside of the CFI-covered region (so that
> in the unlikely event of being caught at the push there won't be an
> ill
> assumption that a [fake] return address is already on the stack, or
> that
> there is a return address at all):

Done.

-Andi
