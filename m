Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTKNTOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTKNTOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:14:23 -0500
Received: from dp.samba.org ([66.70.73.150]:2195 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264338AbTKNTOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:14:22 -0500
Date: Sat, 15 Nov 2003 06:10:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Jack Steiner <steiner@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031114191045.GN26020@krispykreme>
References: <20031110215844.GC21632@sgi.com> <20031111082915.GC1130@llm08.in.ibm.com> <20031111115804.4aaafd28.akpm@osdl.org> <20031114174535.GA30388@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114174535.GA30388@sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Probably too late for 2.6.0, but here is a patch that disables noirqdebug:

Why dont you just disable it during boot somewhere in sgi ia64 specific
code? It doesnt seem right to disable this after all the driver effort
it took to make it work.

And yes Im a paid up member of the "we build stupidly big machines"
club. I'll disable where applicable in ppc64 specific code.

Anton
