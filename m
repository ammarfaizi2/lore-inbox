Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTGFUNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGFUNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:13:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:25571 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263375AbTGFUNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:13:14 -0400
Message-ID: <3F08858E.8000907@us.ibm.com>
Date: Sun, 06 Jul 2003 13:24:46 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: palbrecht@qwest.net
CC: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linux (2.4.18) places incoming connection requests into the syn_recd state
> when the server's backlog queue is full.  I thought they were supposed to be
> discarded if the server's backlog is full, forcing the client to
> subsequently retransmit the request after it times out.  Why does linux put
> the server side into the syn_recd state when its backlog is full?

Do you have tcp_syncookies on? And are you exceeding
the len as configured by tcp_max_syn_backlog?

thanks,
Nivedita

[Please cc or post to netdev, like most networking folk,
  dont subscribe to lkml]


