Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279865AbRKGDN5>; Tue, 6 Nov 2001 22:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280634AbRKGDNq>; Tue, 6 Nov 2001 22:13:46 -0500
Received: from queen.bee.lk ([203.143.12.182]:21638 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S279865AbRKGDNj>;
	Tue, 6 Nov 2001 22:13:39 -0500
Date: Wed, 7 Nov 2001 09:13:14 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Robert Love <rml@tech9.net>, torvalds@transmeta.com
Cc: Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Are -final releases realy FINAL? (Was Re: kernel 2.4.14 compiling fail for loop device)
Message-ID: <20011107091314.A11202@bee.lk>
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org> <20011105194316.B665@mikef-linux.matchmail.com> <1005019360.897.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1005019360.897.2.camel@phantasy>; from rml@tech9.net on Mon, Nov 05, 2001 at 11:02:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 11:02:36PM -0500, Robert Love wrote:
>
> On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
> >
> > Did anyone have this problem with pre8???
> 
> Nope, it was added post-pre8 to final.  The deactivate_page function was
> removed completely.

Look, Linus.  Things should _not_ happen this way.

Why do we add non-trivial changes when going from last -preX of a test kernel
series to -final?

Please make the last stable -preX the -final _without_ any changes.  This is
the third time this caused problem in recent times (2.4.11-dontuse, parport
compile problems and now loop.o), and why don't we learn from previous
mistakes?

Isn't it stupid that some tarballs in the /pub/linux/kernel/v2.4/ do not even
compile, while those in /pub/linux/kernel/testing/ does?

Regards,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.14-pre7)

I cannot conceive that anybody will require multiplications at the rate
of 40,000 or even 4,000 per hour ...
		-- F. H. Wales (1936)

