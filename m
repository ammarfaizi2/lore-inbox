Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263150AbTC1Vj0>; Fri, 28 Mar 2003 16:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTC1Vj0>; Fri, 28 Mar 2003 16:39:26 -0500
Received: from cpe-024-033-021-148.midsouth.rr.com ([24.33.21.148]:10125 "EHLO
	braindead") by vger.kernel.org with ESMTP id <S263150AbTC1VjZ>;
	Fri, 28 Mar 2003 16:39:25 -0500
From: Warren Turkal <wturkal@cbu.edu>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Arne Koewing <ark@gmx.net>
Subject: Re: [BUG] laptop keyboard, even more info
Date: Fri, 28 Mar 2003 15:50:14 -0600
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200303220605.54478.wturkal@cbu.edu> <87y92zr57o.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me> <1048880210.598.1.camel@teapot>
In-Reply-To: <1048880210.598.1.camel@teapot>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303281550.14426.wturkal@cbu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 March 2003 01:36 pm, Felipe Alfaro Solana wrote:
> On Fri, 2003-03-28 at 10:05, Arne Koewing wrote:
> > >> I have tested that the Fn-F2 combination works in bios and grub and
> > >> continues to work until the 2.5.65 kernel is loaded.
> > >>
> > >> I think this is a regression in the keyboard handling for the 2.5.65
> > >> kernel....
> >
> > I don't think this is caused by the input-layer. Linux is not passing
> > Fn-X keypresses to your BIOS. If you've enabled ACPI that ought to be
> > the reason for this.
>
> Also, XFree86 4.3.0 seems to inhibit Fn key combinations on some
> scenarios. On my laptop, I can't use Fn+F3 to switch between LCD and CRT
> while running X.

Fn key gets killed before X. Also, it works fine in X when I am in 2.5.63.

Warren
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

