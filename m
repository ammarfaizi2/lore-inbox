Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKAKNR>; Wed, 1 Nov 2000 05:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKAKNI>; Wed, 1 Nov 2000 05:13:08 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:58894 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129029AbQKAKM7>; Wed, 1 Nov 2000 05:12:59 -0500
Date: Wed, 1 Nov 2000 02:13:15 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jerry Kelley <jkelley@iei.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc question (off topic)
Message-ID: <20001101021315.A17757@twiddle.net>
In-Reply-To: <001801c041bb$5e894c80$0a00a8c0@gamma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <001801c041bb$5e894c80$0a00a8c0@gamma>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 10:17:36AM -0500, Jerry Kelley wrote:
> Can gcc generate ASM output with the source lines from the C file
> interspersed as comments?

Not directly.  However, gas will happily generate assembler listings
containing the C source.  See "-alh".


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
