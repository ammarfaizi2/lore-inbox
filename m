Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbQJ0R16>; Fri, 27 Oct 2000 13:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQJ0R1t>; Fri, 27 Oct 2000 13:27:49 -0400
Received: from iris.mc.com ([192.233.16.119]:15066 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S129073AbQJ0R1f>;
	Fri, 27 Oct 2000 13:27:35 -0400
From: Mark Salisbury <mbs@mc.com>
Reply-To: mbs@mc.com
To: Jason Wohlgemuth <jswkernel@triad.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL Question
Date: Fri, 27 Oct 2000 13:16:10 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <39F9AF0E.70406@triad.rr.com>
In-Reply-To: <39F9AF0E.70406@triad.rr.com>
MIME-Version: 1.0
Message-Id: <00102713233415.00688@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Jason Wohlgemuth wrote:
> Consider this:
> 
> A subsystem that is statically built into the Linux Kernel is modified 
> to allow the registration of a structure containing function pointers.
> 
> The function pointers corrolate to a set of functions within that subsystem.
> If the new structure of pointers has been registered, the original 
> functions will call the new functions in the structure passing all 
> arguments and returning the return value of the new function.
> 
> With this said, if no structure has been registered, then no 
> functionality is degraded within the kernel.  Only the loss of some cpu 
> time to check the pointers at the top of the old functions.
> 
> Now, if a module is loaded that registers a set of functions that have 
> increased functionality compared to the original functions, if that 
> modules is not based off GPL'd code, must the source code of that module 
> be released under the GPL?
> 
> Thanks in advance,
> Jason Wohlgemuth


the api of the module would be a reimplementation of a GPL'd api
(the function names may have changed, but the base behaviors must be equivalent)

so the question in simple terms might phrased as:

is the API under GPL, or is it the code or are both?

I think the answer is both.
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     |                             **
**------------------------------------------------**
**  "WYGIWYD - What You Get Is What You Deserve"  **
**------------------------------------------------*/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
