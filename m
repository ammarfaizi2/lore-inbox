Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUFVXis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUFVXis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUFVXis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:38:48 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:29328 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265057AbUFVXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:38:46 -0400
Message-ID: <40D8C2FE.3060901@ThinRope.net>
Date: Wed, 23 Jun 2004 08:38:38 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 and rfcomm Oops (BlueTooth)
References: <40D8AB57.5040206@ThinRope.net> <1087942737.4209.49.camel@pegasus>
In-Reply-To: <1087942737.4209.49.camel@pegasus>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
> Hi Kalin,
>>I just managed to start using my phone for ppp via BlueTooth with 2.6.7 (stock + kmsgdump patch).
>>
>>Sometimes I get the foolowing Oops though:

[snip oops]

> 
> what the hell is causing this? I didn't changed anything in the RFCOMM
> TTY layer. Please disable preempt support and try again.

Well, no idea. The keyword here is "sometimes"...

I'll try to find a better way to reproduce this and report again with/without preempt.
AFAIR, last time I got this when I "abruptly" stopped the BT stack on my phone, while using rfcomm for ppp.

Just in case, I updated to bluez-{libs,utils}-2.7, but still got one Oops (essentially the same).

These days I'll have to use the phone and a laptop, but will be away. If I found out something more will post it.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
