Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWGSTCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWGSTCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGSTCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:02:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:42662 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030218AbWGSTCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:02:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Wed, 19 Jul 2006 21:02:17 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607191742.32609.rjw@sisk.pl> <44BE5589.4070403@cmu.edu>
In-Reply-To: <44BE5589.4070403@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607192102.17438.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 17:53, George Nychis wrote:
> Ok, well on my second try suspending to disk and resuming, i'm getting a
> much different outcome... ls returns me resuls, however things are
> slightly off:
> 
> x60s gnychis # ls
> ls: downloads: Permission denied
> ls: host_analysis: Permission denied
> ls: SouthPark: Permission denied
> ls: library: Permission denied
> ls: cmu_dump: Permission denied
> ls: emulator: Permission denied
> ls: paper-KanKat.pdf: Permission denied
> ls: quotes: Permission denied
> ls: school: Permission denied
> ls: cmu_dump2: Permission denied
> host_graphs  host_level  key  mp3  odigw_k_pinw.wma  out-5M  pops  song
>  test.save  thesis_rwork  todo
> x60s gnychis # /etc/init.d/net.wlan0 restart
> mkdir: cannot create directory `/var/lib/init.d/snapshot/9985':
> Input/output error
> cp: target `/var/lib/init.d/snapshot/9985/' is not a directory: No such
> file or directory
>  * Stopping wlan0
>  *   Bringing down wlan0
> /lib/rcscripts/net.modules.d/ifconfig: line 139: /usr/bin/tac: cannot
> execute binary file
>  *     Stopping dhcpcd on wlan0 ...
>                                    [ ok ]
>  *     Shutting down wlan0 ...
>                                    [ ok ]
>  * Starting wlan0
>  *   Configuring wireless network for wlan0
>  *     wlan0 connected to "SMC" at 00:04:E2:7D:D3:E3
>  *     in managed mode (WEP enabled - open)
>  *   Bringing up wlan0
>  *     dhcp
>  *       Running dhcpcd ...
>                                    [ ok ]
>  *       wlan0 received address 192.168.2.101
> x60s gnychis # ping google.com
> bash: ping: command not found
> 
> No clue :\

I guess your disk doesn't wake up.

ls can give you some results from the cache.

Rafael
