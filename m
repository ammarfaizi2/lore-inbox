Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVCCJuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVCCJuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVCCJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:50:04 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:4325 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261858AbVCCJtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:49:12 -0500
Message-ID: <4226DD45.1070107@keyaccess.nl>
Date: Thu, 03 Mar 2005 10:47:49 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>2.6.x-pre: bugfixes and features
>>2.6.x-rc: bugfixes only
> 
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.

Speaking, presumably, as one of those people you are talking about, no, 
that is not correct.

Between 2.6.6-rc3 and 2.6.6, you merged an IDE patch that made my disk 
complain loudly and at the time I was fairly annoyed by that. I had been 
testing all the -rc's but then wondered what the point had been. Things 
could break anytime anyways so it seemed I might as well test whenever I 
personally felt like it rather than on anyone else's schedule, which is 
exactly what I did for a while.

Up to this point, I really only grab an -rc if I'm not doing anything 
interesting otherwise.

And this is just because your -rc's aren't -rc's. Yes, in a sense it's 
all just naming and I've been telling others that complained about it as 
much, but in the sense that I'm not testing as many -rc's as you would 
apparently like me to, it is more substantial after all.

Your even/odd point releases will not work. In no time at all the same 
people that now avoid -rc will then avoid odd releases, and they are the 
same people that will avoid the -pre releases. They are _not_ the exact 
same group of people that will be avoiding a real -rc as well though. I 
for instance would be likely to test every -rc you release, on the 
promise that if the thing works out it's final.

Doing -pre and real -rc will get you more testers for -rc. Whether or 
not it's enough remains to be seen, but it seems like something you 
could test out for a few months without much problem.

Add in the fourth level .k releases for real problematic bugs found 
after release as you did with 2.6.8.1, and I believe things should work.

Rene.
