Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUJFPhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUJFPhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJFPhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:37:50 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34779 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269297AbUJFPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:32:28 -0400
Message-ID: <41640FE2.3080704@nortelnetworks.com>
Date: Wed, 06 Oct 2004 09:31:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: root@chaos.analogic.com, joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>	<20041006080104.76f862e6.davem@davemloft.net>	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net>
In-Reply-To: <20041006082145.7b765385.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> So if select returns true, and another one of your threads
> reads all the data from the file descriptor, what would you
> like the behavior to be for the current thread when it calls
> read?

What about the single-threaded case?

Chris

