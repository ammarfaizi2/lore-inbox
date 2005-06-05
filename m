Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVFEAT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFEAT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 20:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFEAT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 20:19:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9411 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261450AbVFEATv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 20:19:51 -0400
Message-ID: <42A24523.5010404@pobox.com>
Date: Sat, 04 Jun 2005 20:19:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git-shortlog script
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org> <42A24274.7040906@pobox.com> <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
>>I'm surprised git doesn't fall back to GIT_COMMITTER_NAME if 
>>GIT_AUTHOR_NAME doesn't exist, though.
> 
> 
> GIT_AUTHOR_NAME existed first ;)
> 
> Btw, what does your /etc/passwd look like, and I'll try to hack it up to 
> just get that case right by default too..

ah, it looks like I forget the name when I was creating the account.

> [jgarzik@pretzel libata-dev]$ grep jgarzik /etc/passwd
> jgarzik:x:500:500::/g/g:/bin/bash

> [jgarzik@pretzel libata-dev]$ chfn
> Changing finger information for jgarzik.
> Password: 
> Name []: Jeff Garzik
> Office []: 
> Office Phone []: 
> Home Phone []: 
> 
> Finger information changed.

Fixed.  :)

In any case, I'll set GIT_AUTHOR_NAME in .bash_profile, to get my proper 
email addy rather than the local one.

	Jeff


