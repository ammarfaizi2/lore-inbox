Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUGNRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUGNRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267485AbUGNRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:15:25 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:48863 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267490AbUGNRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:15:20 -0400
Date: Wed, 14 Jul 2004 13:18:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mark Hamilton <man@ucs.co.za>, linux-kernel@vger.kernel.org,
       Berend <bds@ucs.co.za>
Subject: Re: HP Proliant ML350 kernel panic
In-Reply-To: <20040714122655.GB12431@logos.cnet>
Message-ID: <Pine.LNX.4.58.0407141316180.27526@montezuma.fsmlabs.com>
References: <1088165491.2255.62.camel@man.ucs.co.za> <20040714122655.GB12431@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004, Marcelo Tosatti wrote:

> Couple of questions
>
> Is it always the same oops / Do you have other oopses saved ?
> Can you run the oopses through ksymoops ?
> Is the hardware exactly the same in the three boxes ?
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 00000001
> >
> > *pde = 00000000
> > Oops = 0000
> > CPU: 0
> > EIP: 0010:[<00000001>] Not tainted

This looks very suspicious, single bit set trying to follow a function
pointer. Try running memtest.
