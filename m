Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVI3OLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVI3OLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVI3OLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:11:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:55172 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030310AbVI3OLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:11:09 -0400
Message-ID: <433D477A.4010009@pobox.com>
Date: Fri, 30 Sep 2005 10:11:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>	<433D1E5D.20303@pobox.com> <7v64si4von.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7v64si4von.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
>>2) What is the easiest way to obtain a list of changes present in 
>>repository B, that are not present in repository A?  I used to use 
>>git-changes-script [hacked cg-log script] for this:
> 
> 
> I think I still have the copy you sent to the list.  If you do
> not mind me placing in the master branch just holler -- better
> yet please send a patch with commit log and signoff to add the
> latest, and I will apply it.

It's archived here:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script

but it needs a git expert (read: not me :)) to fix it up for the very 
latest git-core stuff.

Currently, using 'git-changes-script -L ../linux-2.6' spits out
> --------------------------
> commit 2fca877b68b2b4fc5b94277858a1bedd46017cde
> usage: git-cat-file [-t | -s | <type>] <sha1>
> 
> --------------------------
> commit ff40c6d3d1437ecdf295b8e39adcb06c3d6021ef
> usage: git-cat-file [-t | -s | <type>] <sha1>
> 
> --------------------------
> commit 8bf62ecee58360749c5f0e68bc97d5e02a6816b1
> usage: git-cat-file [-t | -s | <type>] <sha1>
> 
> --------------------------

Regards,

	Jeff



