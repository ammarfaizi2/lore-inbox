Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269315AbUJFP6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269315AbUJFP6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUJFP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:58:35 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55292 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269315AbUJFP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:58:34 -0400
Message-ID: <416415E5.8040709@nortelnetworks.com>
Date: Wed, 06 Oct 2004 09:57:25 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: root@chaos.analogic.com, joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>	<20041006080104.76f862e6.davem@davemloft.net>	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>	<20041006082145.7b765385.davem@davemloft.net>	<Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <20041006084242.3443b2de.davem@davemloft.net>
In-Reply-To: <20041006084242.3443b2de.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:

>>Somebody else responded that a bad checksum could do the same
>>thing --not. Select must return correct information.

> Guess what, our UDP implementation does exactly that
> and has done so for years.  It's perfectly fine.

We may want change the man page for select() so that this is made clear.

Chris
