Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271751AbTHGAXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTHGAXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:23:02 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:4623 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271751AbTHGAXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:23:00 -0400
Message-ID: <3F319EE7.8010409@techsource.com>
Date: Wed, 06 Aug 2003 20:35:51 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
References: <200308061830.05586.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Josef 'Jeff' Sipek wrote:
> Just a simple fix to make the statements more readable. (instead of
> "i < TIMEOUT > 0" the statement is divided into two, joined by &&.)
> 


Can you really DO (x < y > z) and have it work as an anded pair of 
comparisons?  Maybe this is an addition to C that I am not aware of.

I would expect (x < y > z) to be equivalent to ((x < y) > z).


