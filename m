Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTIPK1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 06:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTIPK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 06:27:44 -0400
Received: from [80.80.104.119] ([80.80.104.119]:15488 "EHLO ns.ugavia.ru")
	by vger.kernel.org with ESMTP id S261840AbTIPK1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 06:27:43 -0400
Message-ID: <3F66E46D.2060000@isfera.ru>
Date: Tue, 16 Sep 2003 14:22:37 +0400
From: Diadon <diadon@isfera.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Netfilter problem with new 2.4.22
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing 2.4.22
this chain doesn't work
$IPPROG -A OUTPUT -p tcp --dport 113 -j REJECT --reject-with tcp-reset

On 2.4.21 all works fine
In tcpdump on 2.4.21:
14:41:41.752557 somehost.auth > somehost1.32825: R 0:0(0) ack 217583467 
win 0 (DF)

In tcpdump on 2.4.22:
nothing.......


any ideas?

