Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTDKQ7s (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDKQ7r (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:59:47 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:52143 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S261326AbTDKQ7n (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 12:59:43 -0400
Message-ID: <20030411171119.21273.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2003 12:11:18 -0500
Subject: Re: [PATCH] new syscall: flink
X-Originating-Ip: 172.153.251.200
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [David Wagner, "should fail closed", ie with
the capability to flink()to any given open file
descriptor disabled by default]

Ok, that's reasonable. I was imagining that
guessing when you need to enable it for an
open fd that is going to be inherited by
someone else's code that may not even have
been written yet is rather a vague proposition,
while guessing when you need to disable it regardless of what the code that you pass it to
does is likely to be all too clear and made
much of in online discussions.

But some application author not noticing that a potential flink() vulnerability is there at all will perhaps be the more common failure
scenario(so I yield the point).

flink() does seem a useful tool that I've wanted in the past (for reasons similar to the linker
example) if one could get around the implicit
security risk of a naive implementation.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

