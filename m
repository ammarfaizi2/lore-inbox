Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUJNWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUJNWUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJNWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:20:00 -0400
Received: from sartre.ispvip.biz ([209.118.182.154]:1224 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S267807AbUJNWSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:18:03 -0400
Subject: Re: eth1394 performace
From: "Michael J. Cohen" <mjc@unre.st>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net,
       linux1394-user@lists.sourceforge.net
In-Reply-To: <1097714485l.6634l.1l@werewolf.able.es>
References: <1097714485l.6634l.1l@werewolf.able.es>
Content-Type: text/plain
Organization: node41 enterprises, llc.
Date: Thu, 14 Oct 2004 18:17:19 -0400
Message-Id: <1097792240.19956.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 00:41 +0000, J.A. Magallon wrote:
> Hi all...
> 
> I'm trying to link an iBook and my linux box (kernel 2.6.9-rc4-mm1) via FireWire.
> With static IP addresses, it seems to work, but performance is sloow (compared
> to what I expected;):
> 
> werewolf:/usr/src/linux# iperf -c ibook
> ------------------------------------------------------------
> Client connecting to ibook, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.0.1 port 33155 connected with 192.168.0.2 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec   110 MBytes  91.8 Mbits/sec
> werewolf:/usr/src/linux# iperf -c ibook-fw
> ------------------------------------------------------------
> Client connecting to ibook-fw, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.1 port 33156 connected with 192.168.1.2 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec  90.5 MBytes  75.8 Mbits/sec

Try transferring larger amounts of data. perhaps there is not enough
data to provide a meaningful bandwidth measurement.

HTH,
Michael

