Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312872AbSC0BIW>; Tue, 26 Mar 2002 20:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312873AbSC0BIC>; Tue, 26 Mar 2002 20:08:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:61840 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S312872AbSC0BIA>;
	Tue, 26 Mar 2002 20:08:00 -0500
Date: Tue, 26 Mar 2002 17:07:43 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020326170743.A19912@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020316115726.B19495@hq.fsmlabs.com> <Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:16:16AM -0800, Linus Torvalds wrote:
> But alpha does a "pseudo-hardware" fill of page tables, ie as far as the
> OS is concerned you might as well consider it hardware. And that is
> actually limited to 8kB pages

Actually, it can be frobbed up to 64k with a pal call.  Not that
we've ever arranged for the alpha backend to allow for a page size
not equal to 8k...

> The upcoming hammer stuff from AMD is also 64-bit, and apparently a
> four-level page table, each with 512 entries and 4kB pages.

And FWIW, ev6 also has an option to do 4 level page tables.


r~
