Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266086AbUFWDAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUFWDAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFWDAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:00:43 -0400
Received: from ozlabs.org ([203.10.76.45]:28054 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266086AbUFWDAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:00:36 -0400
Date: Wed, 23 Jun 2004 13:00:12 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org, akpm@osdl.org
Subject: Re: [profile]: [0/23] mmap() support for /proc/profile
Message-ID: <20040623030012.GA22495@krispykreme>
References: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com> <20040622231646.GA17387@krispykreme> <20040623020506.GA1832@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623020506.GA1832@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Well, this is a little different. I was more concerned about the
> "Heisenberg effect" that the in-kernel copies to fetch profiling data
> had upon the data fetched. i.e. instead of idle time and the stuff I
> was looking for, I saw copy_to_user() and all kinds of vfs and /proc/
> crap instead, which blew what I was looking for completely out of the
> top 20. The profiling I did was on UP, which was done in part to
> eliminate lock contention as the cause of the phenomena I had observed.

Sure, I was just pointing out another area in our profiling code that 
warrants attention :)

Anton
