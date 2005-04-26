Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVDZNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDZNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:17:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261503AbVDZNRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:17:13 -0400
Date: Tue, 26 Apr 2005 15:17:07 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk, akpm@osdl.org,
       ak@suse.de
Subject: Re: [PATCH 5/6][XEN][x86_64] Add macro for debugreg
Message-ID: <20050426131707.GB5098@wotan.suse.de>
References: <20050426113149.GE26614@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426113149.GE26614@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:31:49PM +0200, Vincent Hanquez wrote:
> Hi,
> 
> The following patch add 2 macros to set and get debugreg on x86_64.
> This is useful for Xen because it will need only to redefine each macro
> to a hypervisor call. 
> 
> Please apply, or comments.

Thanks,

It looks good, except that the name of the macro is too long.
I will queue it and fix the name up when I apply. 

If you plan to add a lot more of these I would recommend
to create a new header first, processor.h is already quite crowded.

-Andi
