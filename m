Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUE1WX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUE1WX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUE1WUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:20:44 -0400
Received: from hera.kernel.org ([63.209.29.2]:33434 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264176AbUE1WQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:16:55 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: ftp.kernel.org
Date: Fri, 28 May 2004 22:16:10 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c98dna$p8d$1@terminus.zytor.com>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528085523.GP1912@lug-owl.de> <200405281210.32382.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085782570 25870 127.0.0.1 (28 May 2004 22:16:10 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 28 May 2004 22:16:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200405281210.32382.m.watts@eris.qinetiq.com>
By author:    Mark Watts <m.watts@eris.qinetiq.com>
In newsgroup: linux.dev.kernel
> >
> > If you see aborts, properly set the timeout parameter...
> 
> Not aborts, more like this every so often:
> 
> rsync: connection unexpectedly closed (598189175 bytes read so far)
> rsync error: error in rsync protocol data stream (code 12) at io.c(189)
> rsync: writefd_unbuffered failed to write 4092 bytes: phase "unknown": Broken
> pipe
> rsync error: error in rsync protocol data stream (code 12) at io.c(666)
> 

That is how rsync reacts to having its connection broken.

	-hpa
