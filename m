Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSBUAvf>; Wed, 20 Feb 2002 19:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292604AbSBUAvZ>; Wed, 20 Feb 2002 19:51:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:9735 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292599AbSBUAvH>;
	Wed, 20 Feb 2002 19:51:07 -0500
Subject: Re: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl':
	dereferencing pointer to incomplete type
From: Robert Love <rml@tech9.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <15476.13477.917508.854100@notabene.cse.unsw.edu.au>
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
	<15476.1699.209321.808094@notabene.cse.unsw.edu.au>
	<1014238274.18361.62.camel@phantasy> 
	<15476.13477.917508.854100@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 19:51:09 -0500
Message-Id: <1014252669.18346.144.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 18:43, Neil Brown wrote:

> Post in haste ... repent at leisure....
> 
> I made that patch against my current, heavily patches tree as I though
> that the changes to interface.h wouldn't conflict... I was wrong.
> 
> The correct patch, which applies against 2.5.5 and compiles with out
> errors for several combinationg of CONFIG_MODULES enabled or not, and
> CONFIG_NFSD being Y, M, or N, is below.

Worked for me, at least in my combination (CONFIG_MODULE=y,
CONFIG_NFSD=n).  Thanks.

Don't forget to pass it to Linus ;)

	Robert Love

