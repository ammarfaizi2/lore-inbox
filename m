Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTJACGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTJACGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:06:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:10214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbTJACGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:06:18 -0400
Date: Tue, 30 Sep 2003 19:07:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: jamie@shareable.org, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20030930190711.6b8b731e.akpm@osdl.org>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFCD@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D3720017304AFCD@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> wrote:
>
>  > I think we should fix up userspace.
>  What do you mean by this? Patch user code at runtime (it's much more
>  complex than it sounds) or remove prefetch instructions from userspace?

Detect when user code stumbles over this CPU errata and make it look like
nothing happened.

