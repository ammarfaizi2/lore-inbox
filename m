Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbQJaOlo>; Tue, 31 Oct 2000 09:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130172AbQJaOle>; Tue, 31 Oct 2000 09:41:34 -0500
Received: from ns.dce.bg ([212.50.14.242]:21259 "HELO home.dce.bg")
	by vger.kernel.org with SMTP id <S129896AbQJaOlZ>;
	Tue, 31 Oct 2000 09:41:25 -0500
Message-ID: <39FEDA00.706D11EA@dce.bg>
Date: Tue, 31 Oct 2000 16:41:04 +0200
From: Petko Manolov <petkan@dce.bg>
Organization: Deltacom Electronics
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: changed section attributes
In-Reply-To: <17144.973002851@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Tue, 31 Oct 2000 16:29:16 +0200,
> Petko Manolov <petkan@dce.bg> wrote:
> >I wonder why the compiler decides to add ".section
> >.modinfo,"a",@progbits"
> >May be this is the thing which should be fixed.
> 
> That is just gcc speak for section .modinfo is marked as allocated,
> type progbits.  Read the ELF standard if you want to know more.


I already red the info as pages, but the description was too brief.

If this is default gcc behavior then it seems that changing to latest
modutils is the only option ;-)

I wonder if Linus will apply your patch.


best,
Petkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
