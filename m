Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270552AbRHQTWQ>; Fri, 17 Aug 2001 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270584AbRHQTWH>; Fri, 17 Aug 2001 15:22:07 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:49544 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S270552AbRHQTVu>; Fri, 17 Aug 2001 15:21:50 -0400
Date: Fri, 17 Aug 2001 15:21:59 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: min() and max() in kernel.h ?
Message-ID: <20010817152159.A15459@alcove.wittsend.com>
Mail-Followup-To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108171913.f7HJDKi00416@wildsau.idv-edu.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <200108171913.f7HJDKi00416@wildsau.idv-edu.uni-linz.ac.at>; from herp@wildsau.idv-edu.uni-linz.ac.at on Fri, Aug 17, 2001 at 09:13:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 09:13:20PM +0200, Herbert Rosmanith wrote:

> hi,

> just now I tried to compile some module and noticed that it doesnt
> compile anymore because "macro min used with only two arguments".
> I had some "#define min(a,b) (a<b?a:b)" myself.

> I then found min() being defined in <linux/kernel.h> with an additional
> type argument and some superfluos (imo) assignment code. Erm. What's going
> next, drawing elipses in kernel?

> I'm also missing some comment who added min/max to kernel.h, at least
> I want to know who I am going to flame :->

	Please review the flamefest threads in this forum going under the
subjects of "2.4.9 does not compile" and related "[PATCH]".  That will
answer who what when and why, as well as giving you a suitable case of
characters to throw stones, or whatever else is handy, at.

	Rather interesting that Linus ducked out of town just in time
for this...  :->

> /herp

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

