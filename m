Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136230AbRECIec>; Thu, 3 May 2001 04:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136238AbRECIeW>; Thu, 3 May 2001 04:34:22 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:11014 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S136230AbRECIeM>; Thu, 3 May 2001 04:34:12 -0400
Message-ID: <3AF11A0D.FB206A2B@alphalink.com.au>
Date: Thu, 03 May 2001 18:42:53 +1000
From: Greg Banks <gnb@alphalink.com.au>
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: esr@thyrsus.com
CC: CML2 <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
In-Reply-To: <20010503034755.A27693@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> 

  I agree with the main thrust of your argument, but

> It would be hard to know how to order your candidates to present
> them to the user in a natural sequence -- and the problem of deciding
> which variable to present for mutation by the user next, if you choose
> that UI, equates to this.

  There is a natural order for presenting variables to the
user, and that's the menu tree order.  At least in the Linux
kernel CML2 corpus the menus are roughly organised from most
general to most specific options, so options appearing earlier
in the tree are likely to appear in more constraints and you
probably want to ask the user to mutate them later.

Greg.
-- 
If it's a choice between being a paranoid, hyper-suspicious global
village idiot, or a gullible, mega-trusting sheep, I don't look
good in mint sauce.                      - jd, slashdot, 11Feb2000.
