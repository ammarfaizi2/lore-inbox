Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRJHWDZ>; Mon, 8 Oct 2001 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277166AbRJHWDG>; Mon, 8 Oct 2001 18:03:06 -0400
Received: from www.transvirtual.com ([206.14.214.140]:48905 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277168AbRJHWCx>; Mon, 8 Oct 2001 18:02:53 -0400
Date: Mon, 8 Oct 2001 15:03:09 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: war <war@starband.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.11-5 Compile Error AIC7XXX_OLD.C
In-Reply-To: <3BC22084.22061F19@starband.net>
Message-ID: <Pine.LNX.4.10.10110081502110.5395-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> erred-stack-boundary=2 -march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
> aic7xxx_old.c:11966: parse error before string constant
> aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
> `MODULE_LICENSE'
> aic7xxx_old.c:11966: warning: function declaration isn't a prototype
> aic7xxx_old.c:11966: warning: data definition has no type or storage
> class

MODULE_LICENSE is in 2.4.10. You need to use that driver against that
kernel.

