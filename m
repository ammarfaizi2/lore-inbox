Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUCGTng (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 14:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCGTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 14:43:36 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:31648 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262310AbUCGTne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 14:43:34 -0500
Date: Mon, 08 Mar 2004 03:42:59 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Roland Dreier" <roland@topspin.com>,
       "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Linux 2.4.26-pre2
Cc: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
References: <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl> <52y8qcv6fy.fsf@topspin.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4ibpxlt4evsfm@smtp.pacific.net.th>
In-Reply-To: <52y8qcv6fy.fsf@topspin.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2004 10:49:05 -0800, Roland Dreier <roland@topspin.com> wrote:

>     Eyal> In standard C we declare all variables at the top of a
>     Eyal> function. While some compilers allow extension, it is not a
>     Eyal> good idea to get used to them if we want portable code.
>
>     Horst> Oh, come on. This is _kernel_ code, it won't ever be
>     Horst> compiled with anything not GCC-compatible.
>
> gcc 2.95 rejects declarations after code.  The kernel, especially
> kernel 2.4, shouldn't use this particular extension, even if gcc 3
> accepts it.
>

I also use gcc 2.95 and have no intention to change compilers
for 2.4 at all as this compiler is most dependable and never
screwed up unlike 3.1.x and 3.2.2.

Documentation/Codingstyle also refers to K&R who historically
declare variables at the top of a function.

Excerpt:
	"all right-thinking people know that
	(a) K&R are _right_ and (b) K&R are right"

Regards
Michael
