Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274260AbRIXXwB>; Mon, 24 Sep 2001 19:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274257AbRIXXvv>; Mon, 24 Sep 2001 19:51:51 -0400
Received: from are.twiddle.net ([64.81.246.98]:38038 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S274254AbRIXXvp>;
	Mon, 24 Sep 2001 19:51:45 -0400
Date: Mon, 24 Sep 2001 16:52:07 -0700
From: Richard Henderson <rth@twiddle.net>
To: James McKenzie <kernel@ostrich.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha 4K mmap offsets and em86
Message-ID: <20010924165207.A14521@twiddle.net>
Mail-Followup-To: James McKenzie <kernel@ostrich.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010923123042.B32649@hecate.esc.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010923123042.B32649@hecate.esc.cam.ac.uk>; from kernel@ostrich.dhs.org on Sun, Sep 23, 2001 at 12:30:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 12:30:42PM +0100, James McKenzie wrote:
> On 2.2 on an alpha you could do
> mmap(NULL,3176, ... , fd, 0x1000);
> but now in 2.4 but in 2.4 it returns EINVAL.

There is code elsewhere in em86 to fake 4k mappings.
You should be able to reuse that.


r~
