Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGZODY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGZODY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWGZODY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:03:24 -0400
Received: from [212.33.180.251] ([212.33.180.251]:24586 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751628AbWGZODX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:03:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Wed, 26 Jul 2006 17:04:35 +0300
User-Agent: KMail/1.5
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
References: <200607241857.52389.a1426z@gawab.com> <200607261423.03527.a1426z@gawab.com> <200607261234.k6QCY7Eb022487@turing-police.cc.vt.edu>
In-Reply-To: <200607261234.k6QCY7Eb022487@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607261704.35399.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 26 Jul 2006 14:23:03 +0300, Al Boldi said:
> > Running different scheds on a single RQ at the same time on the same
> > resource would be rather odd.  That's why independent RQs are necessary
> > even on SMP. OTOH, running independent RQs on UP doesn't make much
> > sense, unless there is a way to relate them.
>
> Exactly..
>
> (But now I'm confused why you said SMP and UP were conceptually the same a
> few notes back...)

The important part here is 'unless there is a way to relate them', at which 
point UP and MP should be conceptually the same, while possibly differing in 
the implementation details.

Thanks!

--
Al


