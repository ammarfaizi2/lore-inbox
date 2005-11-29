Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVK2V5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVK2V5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVK2V5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:57:47 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:54734 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932433AbVK2V5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:57:46 -0500
Message-ID: <438CCF65.4060506@tmr.com>
Date: Tue, 29 Nov 2005 17:00:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jonathan@jonmasters.org
CC: Andrew Morton <akpm@osdl.org>, cp@absolutedigital.net,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>	 <20051116005958.25adcd4a.akpm@osdl.org>	 <20051119034456.GA10526@apogee.jonmasters.org>	 <20051121233131.793f0d04.akpm@osdl.org>	 <35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>	 <20051122141628.41f3134f.akpm@osdl.org> <438B4E85.2060801@tmr.com> <35fb2e590511281233r49668895hc3295fce4cfe891b@mail.gmail.com>
In-Reply-To: <35fb2e590511281233r49668895hc3295fce4cfe891b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:
> On 11/28/05, Bill Davidsen <davidsen@tmr.com> wrote:
> 
> 
>>I think that's best, because there are few people (relatively) using
>>floppy, and those who are probably are used to old behaviour.
> 
> 
> The point of the thread is more that this exposes behaviour which
> might be present in other drivers too - assuming the block device
> state matches the underlying media.

You missed my point... Andrew suggested that since the new behaviour is
not fully functional that a revert was in order until a new version is
available. I agreed, because the old broken behaviour is at least
expected, while waiting for the floppy driver to check is not, and old
problems are less likely to cause a problem until a fixed fix is in place.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

