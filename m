Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263653AbUEKVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUEKVBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUEKVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:01:38 -0400
Received: from fmr04.intel.com ([143.183.121.6]:56770 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263653AbUEKVBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:01:36 -0400
Message-Id: <200405112101.i4BL1JF19217@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Cc: <hch@infradead.org>, <geoff@linux.jf.intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] [PATCH] Performance of del_timer_sync
Date: Tue, 11 May 2004 14:01:21 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ3mky9+ruAmk4rQwOmqfvZLoriKAAACVZw
In-Reply-To: <20040511205712.GA7795@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Ingo Molnar wrote on Tuesday, May 11, 2004 1:57 PM
> * Andrew Morton <akpm@osdl.org> wrote:
>
> > > > Nah, that's ungrammatical.  del_timer_singleshot means "delete a timer
> > > > in a single-shot manner".
> > > >
> > > > We have:
> > > >
> > > > "add a timer"
> > > > "modify a timer"
> > > > "delete a timer"
> > > > "delete a timer synchronously"
> > > > "delete a single-shot timer"
> > >
> > > hm, indeed. Miraculously, the existing timer API names are correct
> > > grammatically, so we might as well go for del_single_shot_timer() ...
> > >
> >
> > <anal>del_singleshot_timer_sync</anal>
> >
> > I vote we leave it up to Ken.  But please, not del_timer_kenneth().
>
> yeah. Ken's got a license to name ;)

Cool, feeling pretty good here. I'm going to stick with andrew's original
name, and add a big fat comments for the new function ;-)

- Ken


