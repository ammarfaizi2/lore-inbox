Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUJYMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUJYMtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUJYMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:49:42 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:55720 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261776AbUJYMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:49:36 -0400
Message-ID: <417CF65C.4040008@yahoo.com.au>
Date: Mon, 25 Oct 2004 22:49:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random> <417A30EE.1030205@yahoo.com.au> <20041023110334.GS14325@dualathlon.random> <417A86AC.2080505@yahoo.com.au> <20041025124443.GV14325@dualathlon.random>
In-Reply-To: <20041025124443.GV14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> I'll adapt the rest of the code to deal with this and test it in a few
> more minutes.
> 

The current stuff is pretty crufty. I think your changes are
far better (aside from the minor fact they won't compile!).

Also, switching to a calculation that has seen some real-world
use would be a good idea before we think about turning it on
by default.
