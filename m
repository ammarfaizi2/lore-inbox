Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286347AbRLJST2>; Mon, 10 Dec 2001 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286341AbRLJSTY>; Mon, 10 Dec 2001 13:19:24 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:14576 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S286345AbRLJSSd>; Mon, 10 Dec 2001 13:18:33 -0500
Date: Mon, 10 Dec 2001 18:18:09 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Andrew Morton <akpm@zip.com.au>, sct@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 writeback mode slower than ordered mode?
Message-ID: <20011210181809.J1919@redhat.com>
In-Reply-To: <871yi5wh93.fsf@atlas.iskon.hr> <3C12C57C.FF93FAC0@zip.com.au> <877krwch39.fsf@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <877krwch39.fsf@atlas.iskon.hr>; from zlatko.calusic@iskon.hr on Sun, Dec 09, 2001 at 08:46:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 09, 2001 at 08:46:02PM +0100, Zlatko Calusic wrote:

> To sumarize:
> 
> ext2            0.01s user 1.86s system 98% cpu 1.893 total
> ext3/ordered    0.07s user 3.50s system 99% cpu 3.594 total
> ext3/writeback  0.00s user 6.05s system 98% cpu 6.129 total
> 
> What is strange is that not always I've been able to get different
> results for writeback case (comparing to ordered), but when I get it,
> it is repeatable.

So it could be something as basic as disk layout or allocation
pattern.  Hmm.

Could you profile the kernel and see where writeback is spending all
the time, in that case?

Thanks,
 Stephen
