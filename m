Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbULQAkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbULQAkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbULQAjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:39:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:9431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbULQAhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:37:23 -0500
Date: Thu, 16 Dec 2004 16:41:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: lista4@comhem.se
Cc: mr@ramendik.ru, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Message-Id: <20041216164130.2088fbd9.akpm@osdl.org>
In-Reply-To: <3284684.1103119330673.JavaMail.tomcat@pne-ps1-sn1>
References: <3284684.1103119330673.JavaMail.tomcat@pne-ps1-sn1>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa <lista4@comhem.se> wrote:
>
> I've now booted all -rc kernels from 2.6.8 to 2.6.10-rc3 and examined the 
> behaviour of a heavy session with the 3D program Blender with regards to 
> screen freezes and mouse unresponsiveness during memory swap.

Can you identify the kernel release which caused the problem to start?

> I find no problem when blender is the sole (large) application, but when a 
> distributed computing client is running in the background the reported problems 
> surface. I use http://folding.stanford.edu for protein folding.  It runs 
> with a default of nice 19 and sucks up every free CPU cycle.

What sucks up all the CPU?  The application?  kswapd?

How much RAM, how much swap?
