Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbSI2WSr>; Sun, 29 Sep 2002 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSI2WSr>; Sun, 29 Sep 2002 18:18:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:4357 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261830AbSI2WSr>; Sun, 29 Sep 2002 18:18:47 -0400
Date: Sun, 29 Sep 2002 19:23:54 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dave Jones <davej@codemonkey.org.uk>, Robert Love <rml@tech9.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       John Levon <levon@movementarian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] break out task_struct from sched.h
Message-ID: <20020929222353.GC7028@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dave Jones <davej@codemonkey.org.uk>, Robert Love <rml@tech9.net>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	John Levon <levon@movementarian.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0209292242470.7949-100000@gans.physik3.uni-rostock.de> <1033333589.22056.1381.camel@phantasy> <20020929221725.GA7557@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929221725.GA7557@suse.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 29, 2002 at 11:17:25PM +0100, Dave Jones escreveu:
> On Sun, Sep 29, 2002 at 05:06:29PM -0400, Robert Love wrote:
 
>  > > Killing ~600 #include <linux/sched.h> lines however seemed enough for a 
>  > > first round, so I left this for later iterations.
>  > Indeed, good job.

> Seconded. Worth noting that Tim first did this months ago,
> and has been keeping this up to date since. These large patches
> that touch lots of areas go stale very quickly and are always
> a real pain to maintain, and merge. It'd be good if people can
> beat up on this patch a little to catch the more obvious
> compile errors that always result in large shake ups like this.
 
> Then theres the daily sending to Linus until he takes it 8)

Tim, thanks for the good work, I'm with Dave, lets beat this one a bit
and then start sending it regularly to Linus.

- Arnaldo
