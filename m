Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRABVKH>; Tue, 2 Jan 2001 16:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRABVJ5>; Tue, 2 Jan 2001 16:09:57 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:64778 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S131801AbRABVJl>; Tue, 2 Jan 2001 16:09:41 -0500
Date: Tue, 2 Jan 2001 12:39:13 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ghadi Shayban <ghad@triad.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling 2.4 with CVS gcc on Athlon
Message-ID: <20010102123913.A19554@twiddle.net>
In-Reply-To: <3A523635.8080003@triad.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A523635.8080003@triad.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 03:12:37PM -0500, Ghadi Shayban wrote:
> {standard input}: Assembler messages:
> {standard input}:139: Error: bad register name `%%mm0'

This is, in fact, a compiler bug.  Somehow the "%%" in the
source didn't print as "%" as expected.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
