Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUD0Peg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUD0Peg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUD0Peg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:34:36 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:33033 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264174AbUD0Pef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:34:35 -0400
Message-ID: <408E7E79.9080405@techsource.com>
Date: Tue, 27 Apr 2004 11:38:33 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ken Moffat <ken@kenmoffat.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE throughput in 2.6 - it's good!
References: <Pine.LNX.4.58.0404232237140.19797@ppg_penguin>
In-Reply-To: <Pine.LNX.4.58.0404232237140.19797@ppg_penguin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ken Moffat wrote:

> 
> So, despite the numbers shown by hdparm looking worse, when only one
> user is doing anything the performance is actually improved.  I've no
> idea which changes have achieved this, but thanks to whoever were
> involved.


I've done tests using dd to and from the raw block device under 2.4 and 
2.6.  Memory size (kernel boot param mem=) doesn't seem to affect 
performance, so I assume that means that dd to and from the raw block 
device is unbuffered.  When I compare read and write speeds between 2.4 
and 2.6, 2.6 is definately slower.  The last 2.6 kernel I tried this 
with is 2.6.5.

