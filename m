Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSIPPjW>; Mon, 16 Sep 2002 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbSIPPjW>; Mon, 16 Sep 2002 11:39:22 -0400
Received: from [195.223.140.120] ([195.223.140.120]:21104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262331AbSIPPjV>; Mon, 16 Sep 2002 11:39:21 -0400
Date: Mon, 16 Sep 2002 17:44:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: Oops in sched.c on PPro SMP
Message-ID: <20020916154446.GI11605@dualathlon.random>
References: <174178B9-C980-11D6-8873-00039387C942@mac.com> <1032187767.1191.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032187767.1191.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 03:49:27PM +0100, Alan Cox wrote:
> Also does turning off the nmi watchdog junk make the box stable ?

good idea, I didn't though about this one since I only heard the nmi to
lockup hard boxes after hours of load, never to generate any
malfunction, but certainly the nmi handling isn't probably one of the
most exercised hardware paths in the cpus, so it's a good idea to
reproduce with it turned off (OTOH I guess you probably turned it on
explicitly only after you got these troubles, in order to debug them).

Andrea
