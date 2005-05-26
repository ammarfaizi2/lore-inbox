Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEZCkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEZCkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 22:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVEZCkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 22:40:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28375 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261151AbVEZCkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 22:40:12 -0400
Message-ID: <42953700.4090604@pobox.com>
Date: Wed, 25 May 2005 22:40:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [OT] pull request notation
References: <7vll64rugt.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vll64rugt.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"JG" == Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
> JG> Please pull the 'new-ids' branch from
> JG>
> JG> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> JG>
> JG> This add...
> 
> I am not a kernel developer, but I think the way this particular
> pull request is worded can be made much more friendly to Cogito
> users (that probably is the rest of the world except you, me and
> Linus ;-).  They use URL fragment notation to express the branch
> head, like this:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git#new-ids
> 
> At least for me, eyes always skip to the "rsync://..." part
> immediately after seeing "Please pull.." part.
> 
> For Linus I am willing to volunteer updating git-pull-script to
> take the same URL fragment notation, but as Jeff correctly
> pointed out it already takes the "branch" name as its second
> parameter so it probably would not be necessary.

It's up to Linus really, he's the consumer of these messages.

Given that git-pull-script requires two arguments, URL and optional 
branch, it sounds like
'rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
new-ids' would be the best syntax, if it weren't for darned word wrap.

	Jeff



