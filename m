Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317218AbSEXQgG>; Fri, 24 May 2002 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317220AbSEXQgF>; Fri, 24 May 2002 12:36:05 -0400
Received: from [209.184.141.163] ([209.184.141.163]:33971 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317218AbSEXQgE>;
	Fri, 24 May 2002 12:36:04 -0400
Subject: Re: It hurts when I shoot myself in the foot
From: Austin Gonyou <austin@digitalroadkill.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CEE5DFB.985EFF6E@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 24 May 2002 11:36:00 -0500
Message-Id: <1022258160.9600.24.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 10:36, Kasper Dupont wrote:
> Alan Cox wrote:
> > 
> > > If the kernel knew multipliers couldn't it actually use the TSCs
> > > anyway? Of course it would take some work, but is there any
> > > reason why it would not be posible?
> > 
> > In 2.4 yes. In 2.5 it would be close to impossible due to the pre-empt code
> 
> Couldn't that be solved in one of the following ways?
> 
> 1) Disable pre-emption while reading TSC and CPU nr.
> 2) Use affinity for processes pre-empted in kernel mode.
> 3) Disable pre-emption for SMP systems.
> 
Sorry to chime in on this if it isn't appreciated, but wouldn't #3 open
some old wounds again? It seems that it would FMPOV. 

Austin

