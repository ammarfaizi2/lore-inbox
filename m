Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422961AbWJaIMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbWJaIMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWJaIMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:12:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422828AbWJaIMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:12:51 -0500
Date: Tue, 31 Oct 2006 00:12:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-Id: <20061031001238.7d8b273f.akpm@osdl.org>
In-Reply-To: <20061031080132.GA9155@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030191340.1c7f8620.akpm@osdl.org>
	<200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030211046.1c3d62b9.akpm@osdl.org>
	<20061031070351.GB14713@kroah.com>
	<20061030233432.d75955c5.akpm@osdl.org>
	<20061031080132.GA9155@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 00:01:32 -0800
Greg KH <greg@kroah.com> wrote:

> > Here's one: http://userweb.kernel.org/~akpm/s5000364.jpg
> 
> That function (snd_register_device_for_dev), isn't even in 2.6.19-rc3,
> so I don't see how any of my changes could have affected it :)

It runs OK without gregkh-driver-* and oopses with them, so perhaps there's
some interaction there.


