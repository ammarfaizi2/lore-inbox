Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVCCA2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVCCA2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCAYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:24:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:55018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261296AbVCCAXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:23:23 -0500
Date: Wed, 2 Mar 2005 16:23:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302162312.06e22e70.akpm@osdl.org>
In-Reply-To: <42264F6C.8030508@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> IMO too confusing.
>

2.6.even: bugfixes only
2.6.odd: bugfixes and features.

That doesn't even confuse me!

> Developers right now are sitting on big piles, and pushing that back 
> even further means every odd release means you are creating a 
> 2.4.x/2.5.x backport situation every two releases.

No, there is no backporting.  If you have a bug, fix it in 2.6.12-pre. 
There is no need to maintain that bugfix in your 2.6.13-candidate tree.

It's still a linear progression of kernel trees.  The only thing which
changes is the types of patches which we put into even releases.
