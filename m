Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317744AbSGVTFa>; Mon, 22 Jul 2002 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGVTFa>; Mon, 22 Jul 2002 15:05:30 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:57607 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317744AbSGVTF3>; Mon, 22 Jul 2002 15:05:29 -0400
Date: Mon, 22 Jul 2002 20:08:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Dike <jdike@karaya.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - part 1 of 2
Message-ID: <20020722200836.B10041@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Dike <jdike@karaya.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020722183844.A8526@infradead.org> <200207222002.PAA04143@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207222002.PAA04143@ccure.karaya.com>; from jdike@karaya.com on Mon, Jul 22, 2002 at 03:02:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:02:41PM -0500, Jeff Dike wrote:
> hch@infradead.org said:
> > The fastcall definition should go into an asm/ header instead of such
> > hacks.. 
> 
> And I'm supposed to fix this as part of the UML patch?

Yes.  as part of the XFS merge preparation I'm also fixing generic kernel
issues.

> > the disk accounting stuff is also bogus - instead of wasting ram with
> > huge array it should rather be dynamically-allocated in a per-disk
> > structure..
> 
> And this too?

No.  but you could just wait for that going in and live without disk
statistics for that time.. :)

