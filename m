Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUHYSwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUHYSwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUHYSwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:52:38 -0400
Received: from main.gmane.org ([80.91.224.249]:60831 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268305AbUHYSwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:52:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Linux 2.6.9-rc1
Date: Wed, 25 Aug 2004 11:52:30 -0700
Message-ID: <412CDFEE.1010505@triplehelix.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-194-252.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Harald Welte:
...
>   o [NETFILTER]: Make 'helper' list of ip_nat_core static
...

I suspect that this changeset[1] somehow caused this to happen (many 
times) in dmesg:

ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked

It seems to be working properly (NATting two machines behind a local 
network to the Internet.)

Just FYI.

-- 
Joshua Kwan

[1] http://linux.bkbits.net:8080/linux-2.6/cset@1.1803.21.9

