Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTKXXnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTKXXnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:43:22 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64708 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261687AbTKXXnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:43:21 -0500
Date: Mon, 24 Nov 2003 18:41:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
In-Reply-To: <20031124225527.GB1343@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com>
References: <20031121121116.61db0160.akpm@osdl.org>
 <20031124225527.GB1343@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Mike Fedyk wrote:

> I'm getting an oops on boot, right after serial is initialised.
>
> Two things it says:
> BAD EIP!
> Trying to kill init!
>
> Yes, I'm using preempt.  I'll try without, and see if that "fixes" the
> problem, and try some other versions, since the last 2.6 booted on this
> machine is 2.6.0-test6-mm4.

Any chance you can capture the oops in it's entirety? It might also be
worth booting with the 'initcall_debug' kernel parameter.

Thanks

