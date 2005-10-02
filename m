Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVJBJyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVJBJyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVJBJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 05:54:04 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:28393 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751043AbVJBJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 05:54:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Sun, 2 Oct 2005 11:54:59 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, ak@suse.de, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200509281624.29256.rjw@sisk.pl> <200510011203.20828.rjw@sisk.pl> <20051001180804.A12268@unix-os.sc.intel.com>
In-Reply-To: <20051001180804.A12268@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510021154.59804.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 2 of October 2005 03:08, Siddha, Suresh B wrote:
> On Sat, Oct 01, 2005 at 12:03:20PM +0200, Rafael J. Wysocki wrote:
> > It shows that there's something wrong with get_smp_config(), but it shouldn't
> > have been called in the first place, as it was a non-SMP kernel.
> > 
> > The appended patch fixes the issue for me, but still if I run an SMP kernel on this
> > box, it crashes in get_smp_config().
> > 
> > If you want me to debug this further, please tell me what to do next.
> 
> Rafael, can you check if the appended patch fixes your issue.

Yes, it does.

Thanks,
Rafael
