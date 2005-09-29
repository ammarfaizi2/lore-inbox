Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVI2UPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVI2UPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2UPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:15:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17134 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932447AbVI2UPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:15:47 -0400
Message-ID: <433C4B6D.6030701@pobox.com>
Date: Thu, 29 Sep 2005 16:15:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
In-Reply-To: <20050929200252.GA31516@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> You wrote..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ rsync -a --verbose --stats --progress \
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>   .git/
> 
> Could be just..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ git pull
> 
> Likewise, in the next section, git pull doesn't need an argument
> if pulling from the repo it cloned.


Nope.  It intentionally includes the manual rsync because clone/pull 
doesn't seem to grab tags.  Or at least last time I checked...

	Jeff


