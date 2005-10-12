Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVJLBus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVJLBus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVJLBus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:50:48 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:27919 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751281AbVJLBur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:50:47 -0400
From: Felix Oxley <lkml@oxley.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: [PATCH] small Kconfig help text correction for CONFIG_FRAME_POINTER
Date: Wed, 12 Oct 2005 02:50:34 +0100
User-Agent: KMail/1.8.2
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200510112322.22004.jesper.juhl@gmail.com> <20051012012528.GA2845@localhost.localdomain>
In-Reply-To: <20051012012528.GA2845@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510120250.37685.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 02:25, Coywolf Qi Hunt wrote:
> On Tue, Oct 11, 2005 at 11:22:21PM +0200, Jesper Juhl wrote:
>
> Why bother anyway since the original is brief and neat.  (yours could be
> s/if/when/ even)

I would definitely agree with Jesper that the current version needs changing.
However, I don't know technically whether it means:

a) you will need an external debugger to get this information
b) this information will be available in the log (etc) and ALSO via an 
external debugger

regards,
Felix

>
> >  	  If you say Y here the resulting kernel image will be slightly larger
> > -	  and slower, but it might give very useful debugging information
> > -	  on some architectures or you use external debuggers.
> > +	  and slower, but it might give very useful debugging information on
> > +	  some architectures or if you use external debuggers.
> >  	  If you don't debug the kernel, you can say N.
