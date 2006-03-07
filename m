Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWCGDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWCGDEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWCGDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:04:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38887
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932634AbWCGDEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:04:12 -0500
Date: Mon, 06 Mar 2006 19:04:28 -0800 (PST)
Message-Id: <20060306.190428.23731173.davem@davemloft.net>
To: psusi@cfl.rr.com
Cc: bcrl@kvack.org, drepper@gmail.com, da-x@monatomic.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <440CE336.3080504@cfl.rr.com>
References: <20060306233300.GR20768@kvack.org>
	<20060306.162444.107249907.davem@davemloft.net>
	<440CE336.3080504@cfl.rr.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Susi <psusi@cfl.rr.com>
Date: Mon, 06 Mar 2006 20:34:46 -0500

> What is this "net channels"?  I'll do some googling but if you have a 
> direct reference it would be helpful.

You didn't google hard enough, my blog entry on the topic
comes up as the first entry when you google for "Van Jacobson
net channels".

> Maybe you should try using a microkernel then like mach?  The Linux way 
> of doing things is to leave critical services that most user mode code 
> depends on, such as filesystems and the network stack, in the kernel.  I 
> don't think that's going to change.

Oh yee of little faith, and we don't need to go to a microkernel
architecture to move things like parts of the TCP stack into
user space.
