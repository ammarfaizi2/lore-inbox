Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUBMCmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUBMCmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:42:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:41387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266686AbUBMCmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:42:00 -0500
Date: Thu, 12 Feb 2004 18:42:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chad Walstrom <chewie@wookimus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NAT over 3c59x cards freezes interactivity on 2.6.2
Message-Id: <20040212184208.48a93b39.akpm@osdl.org>
In-Reply-To: <20040212171647.GW6864@wookimus.net>
References: <20040212171647.GW6864@wookimus.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad Walstrom <chewie@wookimus.net> wrote:
>
> [2.] DETAILS: Upon upgrading from 2.4.x to 2.6.2, I've noticed that my
>  workstation/NAT box freezes on interactive processes while transfering
>  large files over NAT to other machines on the network. 

Please monitor the system time with top or `vmstat 1'.  Is it excessive?

A kernel profile might tell us what is going on.  See
Documentation/basic_profiling.txt.

If you remove all the netfilter rules, what happens?
