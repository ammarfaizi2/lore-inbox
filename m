Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUC2TTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUC2TTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:19:05 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:47745 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263100AbUC2TTC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:19:02 -0500
Subject: Re: kernel 2.6.4 and nfs lockd.udpport?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Kesten <rwe.piller@the-hidden-realm.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200403290958.i2T9w2fJ029554@mail.bytecamp.net>
References: <200403290958.i2T9w2fJ029554@mail.bytecamp.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080587948.2410.68.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 14:19:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 04:58, skreiv Jan Kesten:
> Hi all! 
> 
> I'm running a 2.6.4 kernel with compiled in nfs support. I have to tie the 
> used ports because there is a firewall to gro through. mountd, statd and 
> rquotad are just fine, I can change ports after booting, no problem. But not 
> for lockd (or nlockmgr), since AFAIK this must be done with boot parameters. 
> 
> I read the docs and found that the parameters sould be lockd.udpport and 
> lockd.tcpport=xxx - but this doesn't work. While booting I got errors that 
> both are unknown boot options. 
> 
> Where is my mistake? 

Someone updated lockd so that it uses a sysctl-based interface instead.
Apparently without changing the docs.

See the contents of /proc/sys/fs/nfs ...

Cheers,
  Trond
