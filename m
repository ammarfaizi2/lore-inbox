Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130844AbRAQXSM>; Wed, 17 Jan 2001 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAQXSD>; Wed, 17 Jan 2001 18:18:03 -0500
Received: from james.kalifornia.com ([208.179.0.2]:2898 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130844AbRAQXRx>; Wed, 17 Jan 2001 18:17:53 -0500
Message-ID: <3A66281C.13161012@linux.com>
Date: Wed, 17 Jan 2001 15:17:48 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: roger@kea.grace.cri.nz
CC: jjs@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [OT]: Linux v.2.4.0 and Netscape 4.76?
In-Reply-To: <200101171922.OAA11493@whio.grace.cri.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

roger@kea.grace.cri.nz wrote:

> I can be a little more specific on this point. Netscape with
> kernel 2.4.0 _does_ connect/download at a few local (New Zealand)
> web sites (maybe 10% of those I've tried). I can't download
> from _any_ distant site. It doesn't die, it just doesn't function
> properly.
>
> Several people have suggested I remove ECN from the kernel, or
> disable it. Well, ECN has never been selected as a config option
> in the kernel, so this is not the source of the problem....

perhaps you have an upstream blocking icmp and having a lower MTU?  Try
setting your MTU down to 576 and see if packets flow.


> Just a data point - Netscape 4.76 is working wonderfully
> for me on several 2.4.x systems - well, netscape does die
> fairly often with bus errors, but when it's running it runs well -

For me, netscape is netscape.  I.e. gobble memory for a few days until I
decide to restart it.  Netscape rarely dies on me.

-d

--
..NOTICE fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
