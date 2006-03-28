Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWC1Qou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWC1Qou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWC1Qou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:44:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40347 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750741AbWC1Qou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:44:50 -0500
To: Matt Ayres <matta@tektonic.net>
Cc: devel@openvz.org, Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	<4428FB90.5000601@sw.ru> <44295AE8.7010200@tektonic.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 09:42:41 -0700
In-Reply-To: <44295AE8.7010200@tektonic.net> (Matt Ayres's message of "Tue,
 28 Mar 2006 10:48:56 -0500")
Message-ID: <m1r74mbjwe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Ayres <matta@tektonic.net> writes:

> I think the Xen guys would disagree with you on this.  Xen claims <3% overhead
> on the XenSource site.
>
> Where did you get these figures from?  What Xen version did you test? What was
> your configuration? Did you have kernel debugging enabled? You can't just post
> numbers without the data to back it up, especially when it conflicts greatly
> with the Xen developers statements.  AFAIK Xen is well on it's way to inclusion
> into the mainstream kernel.

It doesn't matter.  The proof that Xen has more overhead is trivial
Xen does more, and Xen clients don't share resources well.

Nor is this about Xen vs what we are doing.  These are different
non conflicting approaches that operating in completely different
ways and solve a different set of problems.

Xen is about multiple kernels.

The alternative is a supped of chroot.

Eric
