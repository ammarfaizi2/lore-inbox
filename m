Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129425AbQKBTy2>; Thu, 2 Nov 2000 14:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQKBTyS>; Thu, 2 Nov 2000 14:54:18 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:49168 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129281AbQKBTyI>; Thu, 2 Nov 2000 14:54:08 -0500
Date: Thu, 2 Nov 2000 11:37:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: tytso@mit.edu, Jakub Jelinek <jakub@redhat.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
Message-ID: <20001102113726.A19505@twiddle.net>
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com> <20001030081938.K6207@devserv.devel.redhat.com> <39FD9E6A.AD10E699@evision-ventures.com> <20001101094619.A15283@trampoline.thunk.org> <20001101102216.A18206@twiddle.net> <3A015AB9.D3B80830@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A015AB9.D3B80830@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 01:14:49PM +0100, Martin Dalecki wrote:
> However what's the difference in respect of optimization between
> unrolling the abs function by hand and relying on the built in?

Should be nothing.  The expanded source expression should get
folded immediately to an ABS_EXPR node, at which point you are
at exactly the same point as the builtin would have gotten you.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
