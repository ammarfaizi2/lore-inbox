Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVJAARb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVJAARb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVJAARb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:17:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11913 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030517AbVJAARa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:17:30 -0400
Message-ID: <433DD595.4070508@pobox.com>
Date: Fri, 30 Sep 2005 20:17:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
In-Reply-To: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Thanks for all the comments.  I just updated the KHGtG with the
>>feedback I received.  Go to
>>
>>	http://linux.yyz.us/git-howto.html
>>
>>and click reload.  Continued criticism^H^H^Hcomments welcome!
> 
> 
> - To know the current branch, "git branch" is enough (the one '*'-ed)

Click reload, this is already mentioned.


> - rsync(1) a repository is dangerous, it might catch it in the middle of
>   a update and give you an incomplete/messed up copy. Repeat rsync until no
>   change, perhaps?

Usually that's just unlucky.  I have caught kernel.org in the middle of 
a sync once, maybe twice.


> - I understand "git checkout -f" blows away any local changes, no questions
>   asked. Not very nice to suggest that to a newbie...

I constantly run into problems if I -do not- use the "-f" flag.  I 
habitually use it at all times, now.

Thanks,

	Jeff



