Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUIYM4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUIYM4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbUIYM4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:56:09 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:61957 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269320AbUIYM4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:56:06 -0400
Date: Sat, 25 Sep 2004 15:54:59 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Borislav Petkov <petkov@uni-muenster.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOM-killer killed everything
In-Reply-To: <20040925124441.GM9106@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0409251553420.11618@musoma.fsmlabs.com>
References: <200409251326.13915.petkov@uni-muenster.de> <20040925124441.GM9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, William Lee Irwin III wrote:

> On Sat, Sep 25, 2004 at 01:26:13PM +0200, Borislav Petkov wrote:
> > I just started burning an audio cd with cdrecord, ran it as root because of 
> > the SUID changes in 2.6.8 when this big bad guy by the name of OOM-killer 
> > appeared and started killing everything :) I don't know whether the spurious 
> > interrupt issue has something to do with it but according to what I've read 
> > on lkml about it until now, it is supposed to be quite harmless. Sysinfo 
> > + .config attached.
> 
> Usually I only get "Kernel panic: Out of memory and no killable processes..."
> from local DoS testcases; I'd be surprised if anyone tripped over such
> cases by accident unless they're doing something particularly stressful
> (e.g. forking server with zillions of clients) or there's a
> particularly outrageously offensive memory leak.

The burning CD audio one is a known issue afaik, i've run into it before 
too.

	Zwane

