Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWBHFxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWBHFxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbWBHFxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:53:17 -0500
Received: from fmr22.intel.com ([143.183.121.14]:7085 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030545AbWBHFxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:53:15 -0500
Message-Id: <200602080552.k185q9g07813@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Tue, 7 Feb 2006 21:52:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYsYuoXAmFDe7UeSna/IRbBKZlqeQADjLLg
In-Reply-To: <20060208035112.GM3524@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >You patch does more than what you described and is wrong.  Selecting
> > > >platform type should not be tied into selecting SMP nor should it tied
> >...
> > I'm not disagreeing with the SMP bit.  In my very first reply, I
> >...
> 
> It might be related to the fact that I'm not a native English speaker, 
> but for me this reads as if you contradict yourself, and I have 
> therefore problems understanding your emails.

Yeah, I've been flip-flopping on CONFIG_SMP.  I just don't have strong
opinion one way or the other. Having said that, I don't think we should
mix the CONFIG_IA64_GENERIC, which is defined to select platform type
with smp/processor type etc.

But for the bit that this thread started, which disables CONFIG_MCKINLEY
for CONFIG_IA64_GENERIC, it is totally wrong and is the "over my dead
body" type of thing.

- Ken

