Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVIJX53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVIJX53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIJX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:57:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932395AbVIJX52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:57:28 -0400
Date: Sat, 10 Sep 2005 16:56:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-Id: <20050910165659.5eea90d0.akpm@osdl.org>
In-Reply-To: <1126396015l.6300l.1l@werewolf.able.es>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<1126396015l.6300l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 09.08, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> > 
> > (kernel.org propagation is slow.  There's a temp copy at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> > 
> > 
> 
> I can not ifup an interface while iptables is using it.
> Is this expected behaviour ?

Maybe it's expected, but breaking existing userspace is a serious issue.

> There is a possible bug (IMHO) in Mandrake initscripts, that start iptables
> before network interfaces, but this had always worked.
> 
> Any ideas ?

Please always cc netdev@vger.kernel.org on networking matters.
