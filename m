Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDXQuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTDXQuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:50:13 -0400
Received: from watch.techsource.com ([209.208.48.130]:1248 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262652AbTDXQuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:50:11 -0400
Message-ID: <3EA81BBB.3020709@techsource.com>
Date: Thu, 24 Apr 2003 13:15:39 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chuck Ebbert <76306.1226@compuserve.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com> <Pine.LNX.4.53.0304241147420.32073@chaos> <3EA8114A.4020309@techsource.com> <Pine.LNX.4.53.0304241244430.32333@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I meant return ((foo & MASK) && 1);
>
>Try it, you'll like it! No shifts, no jumps.
>
>  
>

Looks sweet!  If the compiler is smart, that is.  I'll add that to my 
repetoire.  I'll have to see what the asm output looks like.


