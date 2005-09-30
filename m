Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVI3OI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVI3OI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVI3OI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:08:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030307AbVI3OIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:08:55 -0400
Message-ID: <433D46F1.9010209@pobox.com>
Date: Fri, 30 Sep 2005 10:08:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com> <20050930120739.GB9328@harddisk-recovery.com>
In-Reply-To: <20050930120739.GB9328@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> FYI, the rsync command to get the tags blows away .git/branches/origin,
> so on the next "git pull", git will tell you "Where do you want to
> fetch from today?".

Agreed, though I always run 'git pull $url' each time, so I never 
noticed this.

Since git clone pulls the tags, I have eliminated the first rsync 
completely.

	Jeff


