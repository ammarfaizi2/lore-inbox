Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSG2KdD>; Mon, 29 Jul 2002 06:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSG2KdD>; Mon, 29 Jul 2002 06:33:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15863 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314546AbSG2KdC>; Mon, 29 Jul 2002 06:33:02 -0400
Subject: Re: [patch] APM fixes, 2.5.29
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <20020729130556.48e6d27d.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0207281152430.12794-100000@localhost.localdomain>
	<Pine.LNX.4.44.0207281326150.21244-100000@localhost.localdomain> 
	<20020729130556.48e6d27d.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 12:51:39 +0100
Message-Id: <1027943499.808.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 04:05, Stephen Rothwell wrote:
> Except, if you read the comment, we never do APM BIOS calls on anything
> but CPU 0.  On SMP the only APM BIOS operation we allow is power off
> and we have code to ensure we are on CPU 0 before we do that .


Until I merge the -ac patch that allows you to force APM on SMP boxes
for the few cases it works right.

