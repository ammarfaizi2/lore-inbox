Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCaO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCaO5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWCaO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:57:17 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:21920 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751378AbWCaO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:57:17 -0500
Date: Fri, 31 Mar 2006 16:55:24 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults --> Just Bad Memory
Message-ID: <20060331165524.29ff5d2a@localhost>
In-Reply-To: <20060328163027.1e755745@localhost>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
	<20060328004137.607e51db.akpm@osdl.org>
	<20060328112241.40b9c975@localhost>
	<20060328132346.GB3300@elf.ucw.cz>
	<20060328163027.1e755745@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 16:30:27 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> Additionally I have tested 2.6.16-rc1 (found BAD after 20 min) and now
> I'm re-testing with 2.6.15.6 --> it is compiling by some hours without
> a single segfault.
> 
> So, I think it could be:
> 
> 1) a memory problem exposed by the different behaviour of the kernel
> 
> 2) a kernel BUG somewhere between 2.6.15 / 2.6.16.

After replacing the problematic memory module I'm unable to reproduce
it... so 2.6.16 is OK :)

-- 
	Paolo Ornati
	Linux 2.6.16.1 on x86_64
