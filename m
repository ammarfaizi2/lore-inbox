Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGVWKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGVWKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUGVWKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:10:39 -0400
Received: from mail.tmr.com ([216.238.38.203]:37650 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262062AbUGVWKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:10:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Thu, 22 Jul 2004 18:13:17 -0400
Organization: TMR Associates, Inc
Message-ID: <cdpdmn$os6$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090533911 25478 192.168.12.100 (22 Jul 2004 22:05:11 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> This patch deletes cryptoloop, which is buggy, unmaintained, and
> reportedly has mutliple security weaknesses. Dropping cryptoloop should
> also help dm-crypt receive more testing and review.

What part of "stable" has escaped your attention? You want your favorite 
feature to mature more quickly, so sod all for the people using the 
existing feature. If you want to use something else go to it, but stop 
trying to make your favorite feature look better by bad-mouthing 
something else, like the politicians I see 20 times an hour on TV.

Yes there are people using cryptoloop, and as a pure matter of cost they 
are not going to change to something else, because they have to get new 
software, reconfigure disks, and most importantly retrain support 
people. You may be a single hobby user or developer, who can d/l all the 
new software, learn everything from a man page in minutes, and who never 
deals with managers or stupid user questions.

Please stop trying to break things in the stable kernel to further your 
personal agenda! This is a feature people are using, it would require a 
significant effort to change, and from what little I follow the crypto 
lists it's not universally agreed that dm-crypt is really secure, 
either. Cryptoloop is WAY better than nothing, which is what the client 
was using on laptops until last year.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
