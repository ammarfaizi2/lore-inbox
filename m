Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTDQQ6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDQQ6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:58:54 -0400
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:40902 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S261756AbTDQQ6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:58:51 -0400
Date: Thu, 17 Apr 2003 13:10:31 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-admin@vger.kernel.org>, <users@lists.freeswan.org>,
       <sfs-users@freeswan.ca>
Subject: Re: ARP
In-Reply-To: <20030417185540.28c74d42.Christoph.Pleger@uni-dortmund.de>
Message-ID: <Pine.LNX.4.44.0304171308000.6853-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Chris,

On Thu, 17 Apr 2003, Christoph Pleger wrote:

> I want to use FreeS/WAN with kernel 2.4. For the configuration I have to
> reach with FreeS/WAN I need the ability to tell a host that it shall
> accept traffic which is directed to another host. I tried doing that by
> the user space program arp, but it did not work and after that I read in
> the manual page of arp that since kernel version 2.2.0 setting an arp
> entry for a whole subnet is no longer supported. 
> 
> Is there something else I can do to tell the hosts in a subnet to send
> packets for a specific not to that host itself but to another host? This
> should be done transparently so that the hosts do not know that their ip
> packets do not go directly to the destination.

	Proxy arp _does_ work, to the est of my knowledge, still.  You may 
need to put in the entries for each workstation, that that's a simple 
shell loop in your network startup.

http://www.stearns.org/doc/proxyarp-howto

	Please trim the to list on any replies.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	..all in all it's just another rule in the firewall.
	/Ping Flood/
(Courtesy of Hirling Endre)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

