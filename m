Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSHWKKA>; Fri, 23 Aug 2002 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSHWKKA>; Fri, 23 Aug 2002 06:10:00 -0400
Received: from pc-80-195-35-4-ed.blueyonder.co.uk ([80.195.35.4]:10369 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318738AbSHWKJ7>; Fri, 23 Aug 2002 06:09:59 -0400
Date: Fri, 23 Aug 2002 11:14:04 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Stephen Tweedie <sct@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] 2.4.20-pre4/ext3: Fix "buffer_jdirty" assert failure.
Message-ID: <20020823111404.F2801@redhat.com>
References: <200208222319.g7MNJaS09086@sisko.scot.redhat.com> <20020823104905.B12076@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020823104905.B12076@infradead.org>; from hch@infradead.org on Fri, Aug 23, 2002 at 10:49:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 23, 2002 at 10:49:05AM +0100, Christoph Hellwig wrote:

> >  #ifdef __SMP__
> >  	J_ASSERT_JH(jh, current->lock_depth >= 0);
> >  #endif
> 
> Umm, __SMP__ is never defined in 2.4..

Ancient code from the 2.2 ext3.  I'll fix it in CVS and queue it
later.

--Stephen
