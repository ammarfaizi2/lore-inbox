Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbVBEXZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbVBEXZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 18:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268373AbVBEXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 18:25:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52874 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268354AbVBEXZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 18:25:12 -0500
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Shane Hathaway <shane@hathawaymix.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
References: <200502022148.00045.shane@hathawaymix.org>
	<200502041755.41288.hpj@urpla.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Feb 2005 16:23:14 -0700
In-Reply-To: <200502041755.41288.hpj@urpla.net>
Message-ID: <m165164mn1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen <hpj@urpla.net> writes:

> Hi Shane,
> 

> Difference: 181 Bytes (padding ignored)
> 
> The whole module takes about 9K, compared to dhcp in initrd, which 
> takes a few hundred K! Hmm.

And the kinit from the klibc package (A static executable that
does everything the kernel currently does for mounting root
including handling what ipconfig handles it in only 35K (uncompressed).

> That's an interesting question. Please keep me informed on any new 
> perceptions in this respect.
> 
> May the linux gods indulge on this topic one day or remove the 
> ipconfig module completely.

Well that actually is the goal.  A major problem is that there
are enough policy issues that the kernel simply cannot get it right,
for all users.

Eric
