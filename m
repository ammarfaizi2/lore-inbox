Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271599AbRHZWFr>; Sun, 26 Aug 2001 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271600AbRHZWFh>; Sun, 26 Aug 2001 18:05:37 -0400
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:260 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S271599AbRHZWFZ>;
	Sun, 26 Aug 2001 18:05:25 -0400
Subject: Re: [OT] Howl of soul...
To: _deepfire@mail.ru
Date: Sun, 26 Aug 2001 15:06:45 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ajm7-00033e-00@f9.mail.ru> from "Samium Gromoff" at Aug 25, 2001 08:11:23 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010826220645.6D89BB9F08@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > there's nothing wrong with the chipset/controller; isn't this thread
> > about the well-known DTLA problem?  if so, then what mode you use
> > is completely irrelevant, since the physical media is degrading.
> 
>      i feel like the media isn`t downgrading because
>  the badblocks _arent_ physical: low-level drive
>  reformat doesnt show anything.

A low-level format (using IBM DFT) is going to *silently* remap bad
parts of the disk. It's only going to complain once it's no longer
possible to remap the bad sectors. So, just because the low-level format
doesn't complain does not mean that there is no media degradation!

Also, many people seem to be correlating it to heat, and possibly to
flaws in IBM's implementation of glass platters in these drives. For
example, see
http://www.storagereview.com/welcome.pl?/http://www.storagereview.com/jive/sr/thread.jsp?forum=1&thread=16057

-Barry K. Nathan <barryn@pobox.com> 
