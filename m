Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTIJShg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTIJShf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:37:35 -0400
Received: from vlothuizen.xs4all.nl ([213.84.237.248]:52192 "EHLO
	zeus.vlothuizen.nl") by vger.kernel.org with ESMTP id S265488AbTIJShe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:37:34 -0400
Message-ID: <3F5F6F69.CD851A2F@vlothuizen.nl>
Date: Wed, 10 Sep 2003 20:37:29 +0200
From: Wouter Vlothuizen <maillists@vlothuizen.nl>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Weage <weage98@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
References: <20030906162949.27200.qmail@web40405.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Weage wrote:
> 
> has stopped working?  I've looked at nfsstat and the kernel seems to
> have stopped sending any data to the server, or it may send one packet
> every couple of seconds.  If I start up another shell and try to do an
> ls on the problem filesystem, the command locks up and can't be
> interrupted.  I think I've also mounted the same filesystem in another
> location, on the same machine, and it works fine.
> 

I am experiencing similar problems with 2.4.18 as a client (the NFS
server is on Solaris). When the client freezes I see nfsstat 'client rpc
retrans' counting fast. I found a quite strange way to unlock the
machine, by performing a port scan with nmap from elsewhere.
BTW, which Gigabit ethernet do you use, I use tg3, there could be a
relation to the network card?

Cheers,
Wouter
