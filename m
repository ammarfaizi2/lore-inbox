Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUDRFMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbUDRFMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:12:41 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:11421 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264124AbUDRFMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:12:39 -0400
Message-ID: <40820E44.7010208@yahoo.com.au>
Date: Sun, 18 Apr 2004 15:12:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lee <steve@tuxsoft.com>
CC: "'Francois Romieu'" <romieu@fr.zoreil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1 caused dedicated Quake 3 server to core dump
References: <E1BF0rr-0007TG-Rh@server.cyberhostplus.biz>
In-Reply-To: <E1BF0rr-0007TG-Rh@server.cyberhostplus.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lee wrote:
> Ah, I meant to include that in my first email.  It's the latest NVidia
> driver 1.0-5336.  I know, I know, but it's worked fine with 2.6.5 and all
> previous.  Also, just the dedicated quake 3 server core dumped, the quake 3
> client running on the same machine did not crash.  At the time of the crash,
> there were four clients connected to the quake 3 server.  I realize the
> NVidia driver could have corrupted some memory some where else, but if
> that's the case, I would have thought it would have shown this behavior
> previous, and not just with 2.6.6-rc1.  Unless of course, something in
> 2.6.6-rc1 specifically altered something the NVidia driver makes use of.  I
> guess.  :-) 
> 

Hi Steve,
Unfortuately the nvidia driver means nobody is likely to look
into your problem - it is just not a good use of their time.
It would be very helpful if you could try to reproduce the oops
without the nvidia driver loaded though.

It should be possible if the nvidia driver isn't the cause of
the problem.

Nick
