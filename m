Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVJaRwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVJaRwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJaRwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:52:55 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:29104 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932520AbVJaRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:52:55 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net>
References: <20051029182228.GA14495@havoc.gtf.org> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz> <200510310334.35597.rob@landley.net> <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net>
Date: Mon, 31 Oct 2005 09:49:28 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net>
Message-ID: <Pine.LNX.4.62.0510310945400.16906@qynat.qvtvafvgr.pbz>
References: <20051029182228.GA14495@havoc.gtf.org> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz> <200510310334.35597.rob@landley.net>
 <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Giuseppe Bilotta wrote:

> On Mon, 31 Oct 2005 03:34:34 -0600, Rob Landley wrote:
>
>> On Monday 31 October 2005 03:13, David Lang wrote:
>>>> I was thinking about doing thatn in hidden input fields and
>>>> passing form back and forth.  After all what real git bisect
>>>> keeps locally are one bad commit ID and bunch of good commit
>>>> IDs.
>>>
>>> if it's kept in a file or cookie then it can survive a reboot and other
>>> distractions (remember that this process can take days if the problem
>>> doesn't show up at boot). a cookie can hold a couple K worth of data, a
>>> file has no size limit.
>>
>> Actually, lots of Linux browsers these days treats all cookies as session
>> cookies for security reasons.  So surviving a reboot still isn't guaranteed.
>> But it's possible.

I haven't seen a browser that does this (it would break a lot of sites), I 
have seen the option when you go to accept a cookie to accept it for this 
session only, so a note to the user to allow the cookie to persist may be 
enough, or we can just go the tarball route and the file that gets saved 
and uploaded would be enough.

what browser have you seen this default bahavior on?

>> You can also have 'em bookmark a URL...
>
> Trac has a 'Session ID' key that stores something like a cookie,
> except that it's serverside. Something halfway a cookie and an actual
> login. The user can write down the session ID or just assign its own,
> and the re-enter the session ID and all things are restored to the
> settings he had chosen. Something like this, maybe?

saving the state on the server means that you have to deal with (or 
somehow eliminate) collisions between different users, it means that you 
need to have the server-side data time out and get garbage collected, and 
in general adds significant complexity to the project.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
