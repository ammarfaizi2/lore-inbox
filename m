Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSCSSbF>; Tue, 19 Mar 2002 13:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSCSSau>; Tue, 19 Mar 2002 13:30:50 -0500
Received: from Expansa.sns.it ([192.167.206.189]:33290 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289606AbSCSSaI>;
	Tue, 19 Mar 2002 13:30:08 -0500
Date: Tue, 19 Mar 2002 19:30:17 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <3C976AE4.5070309@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203191930060.26263-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that is: __get_hash_table




On Tue, 19 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > HI,
> >
> > also with 2.5.7, as with 2.5.6, I have problems at boot.
> > I get the usual oops while initialising IDE.
> >
> > my ide controller is:
> >
> > 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> > [Master])
> >         Subsystem: Intel Corporation 82801AA IDE
> >         Flags: bus master, medium devsel, latency 0
> >         I/O ports at 2460 [size=16]
> >
> > unfortunatelly, I do not have even the time to write down oops message,
> > but eip is c0135068, but then I do not find a similar entry in system.map
> >
> > any hint
>
> The entries found there are just the starting points of functions.
> You can therefore look up the function where th oops happens
> by looking at the nearest lower number in System.map.
>
> > my rootfs in reiserFS, but i do not even reach the mount ...
>
> That should not matter.
>

