Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbTGJJpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbTGJJpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:45:20 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:25840 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S269140AbTGJJpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:45:18 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Date: Thu, 10 Jul 2003 11:59:49 +0200
User-Agent: KMail/1.5.9
Cc: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307101142.37137.schlicht@uni-mannheim.de> <20030710094841.GU15452@holomorphy.com>
In-Reply-To: <20030710094841.GU15452@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307101159.51175.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 11:48, William Lee Irwin III wrote:
> On Thursday 10 July 2003 11:27, William Lee Irwin III wrote:
> >> Could you try the following?
>
> On Thu, Jul 10, 2003 at 11:42:35AM +0200, Thomas Schlichter wrote:
> > OK, I tried it. For me it compiles!
> > But the size of the resulting objectfile's text section is about 64bytes
> > larger than with my patch. So it seems that gcc3.3 wasn't able to
> > optimize away all the unneeded stuff...
> > And I don't think my patch is that ugly, but hey, it's your decision...
>
> 64B? Why do you care?

It's not the 64B...
I care about the unneeded but executed code!
But I'm a hopeless perfectionist caring about such nits...

And I don't know why everybody hates my patches... ;-(

  Thomas
