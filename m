Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWEQRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWEQRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWEQRwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:52:24 -0400
Received: from b.relay.invitel.net ([62.77.203.4]:38094 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1750821AbWEQRwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:52:24 -0400
Date: Wed, 17 May 2006 19:52:38 +0200
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060517175238.GA32163@lgb.hu>
Reply-To: lgb@lgb.hu
References: <9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com> <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
X-Operating-System: vega Linux 2.6.15-22-686 i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 04:53:35PM +0200, linux cbon wrote:
>  --- Jesper Juhl <jesper.juhl@gmail.com> a écrit : 
> > And when the windowing system crashes it'll take the
> > kernel down with it - ouch.
> 
> It is already happening today with X, because :
> X runs as root - ouch.
> X can write into kernel memory - ouch.
> X can mess with clocks - ouch.
> X can mess with PCI bus - ouch.

What? Check out Xnest or Xephyr, they won't mess up anything :) Sure you
will note here that they require another X server running on, but my point
is that you SHOULD NOT confuse X in whole with an x _implementation_ like
Xorg of XFree86 and even the OS counts they runs on. Sure, you can write an
X server (or port/modify eg Xorg) which does not require root privs, and
others. So you don't want to create a new windowing system if the only
problem you have is about the implementation done by Xorg and/or Linux
kernel, etc etc ...

-- 
- Gábor
