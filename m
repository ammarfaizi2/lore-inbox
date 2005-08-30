Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVH3UmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVH3UmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVH3UmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:42:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20669 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932453AbVH3UmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:42:23 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH 4/9] UML - Mark SMP on UML/x86_64 as broken
References: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Aug 2005 22:42:15 +0200
In-Reply-To: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org>
Message-ID: <p73vf1nqhqw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> Noticed by Al Viro - SMP on x86_64 is fundamentally broken due to
> UML's reuse of the host arch's percpu stuff.  This is OK on x86, but
> the x86_64 pda stuff just won't work for UML.

The generic one should work too, it's just less efficient.
So you can probably easily replace them.

-Andi
