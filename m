Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVCLBmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVCLBmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVCLBfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:35:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:9350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbVCLBdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:33:17 -0500
Date: Fri, 11 Mar 2005 17:33:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
 speedstep even more broken than in 2.6.10
Message-Id: <20050311173308.7a076e8f.akpm@osdl.org>
In-Reply-To: <20050311202122.GA13205@fefe.de>
References: <20050311202122.GA13205@fefe.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Added netdev cc)

Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
>
> Now about IPv6: npush and npoll are two applications I wrote.  npush
> sends multicast announcements and opens a TCP socket.  npoll receives
> the multicast announcement and connects to the source IP/port/scope_id
> of the announcement.  If both are run on the same machine, npoll sees
> the link local address of eth0 as source IP, and the interface number of
> eth0 as scope_id.  So far so good.  Trying to connect() however hangs.
> Since this has been broken in different ways for as long as I can
> remember in Linux, and I keep complaining about it every half a year or
> so.  Can't someone fix this once and for all?  IPv4 checks whether we
> are connecting to our own address and reroutes through loopback, why
> can't IPv6?
> 
