Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbTJ1J4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbTJ1J4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:56:51 -0500
Received: from rth.ninka.net ([216.101.162.244]:34965 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263904AbTJ1Jyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:54:38 -0500
Date: Tue, 28 Oct 2003 01:50:32 -0800
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.or
Subject: Re: status of ipchains in 2.6?
Message-Id: <20031028015032.734caf21.davem@redhat.com>
In-Reply-To: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 17:27:22 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> I recently discovered that ipchains is rather broken.  I noticed the
> problem on ia64, but suspect that it's likely to affect all 64-bit
> platforms (if not 32-bit platforms).  A more detailed description of
> the problem I'm seeing is here:
> 
> 	http://tinyurl.com/sm9d
> 
> Unlike ipchains, iptables works perfectly fine, so perhaps we just
> need to update Kconfig to discourage ipchains on ia64 (and/or other
> 64-bit platforms)?

Might want to post this to the netfilter lists or netdev....
Nah, that might actually get the bug fixed.

linux-kernel is always the wrong place to report networking
problems, most networking developers do not read linux-kernel.
They do read netdev@oss.sgi.com so please post things there.

