Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUEJKAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUEJKAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEJKA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:00:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:24966 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264592AbUEJKAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:00:22 -0400
Date: Mon, 10 May 2004 02:59:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ak@muc.de, luto@myrealbox.com, rjwysocki@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040510025943.3a67ff83.akpm@osdl.org>
In-Reply-To: <1084141013.28220.8.camel@bach>
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no>
	<fa.freqmjk.11j6bhe@ifi.uio.no>
	<409D3507.2030203@myrealbox.com>
	<20040509133231.GA25195@colin2.muc.de>
	<1084141013.28220.8.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  I don't have an x86_64 box, and I ask *again* if someone who does can
>  take a look at the problem...

I have an ia32e box.  And when I boot 2.6.6-mm1 on it with

	console=ttyS0 console=tty0

on the boot command line, stuff comes out on both the serial port and the
vacuum tube, as intended.

So either it accidentally got fixed or it's a heisenbug.

Could other people please retest?
