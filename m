Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWI0Skn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWI0Skn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWI0Skm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:40:42 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:20683 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1030524AbWI0Skl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:40:41 -0400
Date: Wed, 27 Sep 2006 14:40:37 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Markus Dahms <mad@automagically.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Message-ID: <20060927184037.GA3306@athena.road.mcmartin.ca>
References: <200609271424.47824.eike-kernel@sf-tec.de> <pan.2006.09.27.17.56.13.80913@automagically.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2006.09.27.17.56.13.80913@automagically.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 07:56:13PM +0200, Markus Dahms wrote:
> > I get this on my machine. SMP kernel, linus git from this morning. .config
> > and test available on request.
> 

I saw this as well.

Reverting,
>       i386: Remove lock section support in semaphore.h

Fixes it for me (and apparently akpm too from Message-Id:
<20060926224114.5ca873ec.akpm@osdl.org>)

Linus, please revert 01215ad8d83e18321d99e9b5750a6f21cac243a2 for now...

Cheers,
	Kyle McMartin
