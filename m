Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUE1RsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUE1RsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUE1RsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:48:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52945 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263763AbUE1RsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:48:00 -0400
Date: Fri, 28 May 2004 10:46:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>, "Nakajima, Jun" <jun.nakajima@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <17750000.1085766378@flay>
In-Reply-To: <40B7797F.2090204@pobox.com>
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With all due respect, "it might be an embedded box" is not normally a reason why we keep stuff in the kernel.  With initramfs et. al., we are actively moving in the opposite direction.
> 
> If this was the only reason for having kirqd in the kernel, it would be long gone.
> 
> The reason why kirqd hasn't been removed is simply because nobody has stepped up to do a apples-to-apples comparison to prove that userland irqbalanced has any performance advantages, or disadvantages, over kirqd.  From a hard-numbers perspective, compared to kirqd, the userland solution is still largely an unknown quantity.
> 
> irqbalanced makes a lot of sense from a flexibility and policy perspective, and it works on multiple arches, so it has a lot more going for it.
> 
> "We like it in the kernel so we don't have to ship a userland component" is not a valid reason.

Personally, I find the argument that it's hardware-specific control code
a much better reason for it to belong in the kernel. But now it's a config
option, everyone can do what they like ... so there's no need to argue
back and forth any more. Not to say the in-kernel one doesn't need some
fixing up, but we're planning on doing that later this year.

M.

