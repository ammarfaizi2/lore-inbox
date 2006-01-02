Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWABU2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWABU2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWABU2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:28:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751026AbWABU2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:28:36 -0500
Date: Mon, 2 Jan 2006 12:24:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: khc@pm.waw.pl, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-Id: <20060102122441.54139453.akpm@osdl.org>
In-Reply-To: <20060102200934.GA30093@elte.hu>
References: <20051230074916.GC25637@elte.hu>
	<20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu>
	<20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de>
	<20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
	<20060102110341.03636720.akpm@osdl.org>
	<20060102200934.GA30093@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> i marked all things __always_inline that allyesconfig 
>  needs inlined.

I hope you fixed __always_inline too.  It's currently a no-op on all but
alpha.


