Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266952AbUAXPmS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUAXPmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:42:18 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:39609 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266952AbUAXPmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:42:17 -0500
Message-ID: <4012A429.7040902@wanadoo.fr>
Date: Sat, 24 Jan 2004 16:58:17 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Representation of large hex values
References: <20040124151156.GB1029@gallifrey>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert wrote:
> (OK, this isn't strictly a kernel thing - but it seems to be a good
> place for peoples thoughts on this, and the kernel would be one
> place to start it off)
> 
> The problem: Large (64 bit) hex values are cumbersome - especially
> when they contain strings of 0's in the middle
> 
> Suggestion: Print hex value with a seperator every 4 or 8 nybbles
> to aid in counting.  After some discussion it seems that _
> is a decent seperator - e.g.
> 
> 1000_0000_0000_1234

You'll break people piping output to tools, you must
solve this by running the output to your own filter
which split hexa number.

regards,
Phil

