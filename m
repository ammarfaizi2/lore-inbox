Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJaHhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJaHhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:37:37 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:49321 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263062AbTJaHhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:37:35 -0500
Message-ID: <3FA2113B.1020102@cyberone.com.au>
Date: Fri, 31 Oct 2003 18:37:31 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Andrew Morton <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
References: <200310301601.55588.schlicht@uni-mannheim.de> <3FA1943A.7010300@cornell.edu> <3FA1A171.3040807@cyberone.com.au> <200310310828.41598.schlicht@uni-mannheim.de>
In-Reply-To: <200310310828.41598.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Schlichter wrote:

>Hi,
>
>On Friday 31 October 2003 00:40, Nick Piggin wrote:
>
>>Hi,
>>If you're testing IDE TCQ, please try the following patch and use the
>>default io scheduler. It won't fix anything, but it poisons requests
>>so we can sometimes tell if they are being used in the wrong places.
>>I have seen warnings that lead me to believe this might be happening.
>>Its against 2.6.0-test9-mm1. Report any stack traces you see. Thanks.
>>
>
>OK, I tested 2.6.0-test9-mm1 + your patch, but it seems not to print any 
>messages or stack traces, even if many processes are killed after setting TCQ 
>depth to 1.
>

OK well thats good, its not my problem then ;) Thanks.


