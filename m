Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVBCB31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVBCB31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVBCB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:29:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7041 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262896AbVBCB17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:27:59 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Minor Kexec bug fix (2.6.11-rc2-mm2)
References: <1107352593.11609.146.camel@2fwv946.in.ibm.com>
	<42016B55.4000804@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 18:26:03 -0700
In-Reply-To: <42016B55.4000804@osdl.org>
Message-ID: <m1hdku8mdw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Vivek Goyal wrote:
> > Hi Andrew,
> > This patch has been generated against 2.6.11-rc2-mm2. This fixes a very
> > minor bug in kexec.
> 
> Have you run sparse on a kexec-patched kernel tree?
> I have, but not lately.  It needed some s/0/NULL/ in several places,
> but that was before the latest big changes...

I have been avoiding adding more but I have not done had a flag
day and killed them all either.

The one bit int bug was a stupid thinko in the new code.
Totally obvious when someone tried it, to use it.

I think I am about ready to provide a sysrq panic interface.
At least for testing that code path it would be good.  And
if we actually have kernel core dumps it might be useful
beyond that.

Eric


