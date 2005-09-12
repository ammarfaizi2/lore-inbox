Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVILWDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVILWDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVILWDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:03:04 -0400
Received: from [64.162.99.240] ([64.162.99.240]:53673 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S932285AbVILWDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:03:01 -0400
Message-ID: <4325FADB.4090804@spamtest.viacore.net>
Date: Mon, 12 Sep 2005 15:02:03 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43229BA4.4010306@pobox.com>	<20050910163446.GA2232@taniwha.stupidest.org>	<4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net>
In-Reply-To: <20050912.144107.37064900.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>>agreed -- as far as i'm concerned the 32 bit libraries are there for 
>>compatibility's sake and should be in /lib/compat/<subarch> instead of 
>>/lib. the native libraries should be in /lib instead of /lib64. lib64 
>>should just go away!
> 
> 64-bit isn't any more "native" than 32-bit on some 64-bit platforms.
> 32-bit is the default and most desirable userland binary format on
> sparc64 for example.  So 32-bit programs on sparc64 are as "native" as
> 64-bit ones might be considered.

that's true, i had forgotten about the sparc64 case. it really does slow 
down tremendously when used in pure 64 bit mode

i would imagine this not to be the case for most architectures though. 
possibly hppa is the same way. anyone with mips64 and ppc64 hardware out 
there have any input?
