Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWDKTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWDKTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDKTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:50:28 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:45226 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751180AbWDKTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:50:25 -0400
Message-ID: <443C0B74.50305@gentoo.org>
Date: Tue, 11 Apr 2006 21:03:00 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: John Heffner <jheffner@psc.edu>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
References: <443C03E6.7080202@gentoo.org> <443C024C.2070107@psc.edu>
In-Reply-To: <443C024C.2070107@psc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Heffner wrote:
> I'm not seeing this behavior myself.  What are the values of 
> /proc/sys/net/ipv4/tcp_wmem, tcp_rmem, and tcp_mem?  How much memory 
> does this system have?  (A binary tcpdump might be good, too.)

tcp_wmem: 4096    16384   131072
tcp_rmem: 4096    87380   174760
tcp_mem: 98304   131072  196608

tcpdumps coming later. This is on an x86_64 system with 1GB RAM. I 
connect via the forcedeth driver but also reproduced this through ipw2200.

Thanks!
Daniel

