Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUFNV5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUFNV5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:57:30 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:19103 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264500AbUFNV53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:57:29 -0400
Message-ID: <40CE1F42.1020407@nortelnetworks.com>
Date: Mon, 14 Jun 2004 17:57:22 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: upcalls from kernel code to user space daemons
References: <200406142341.13340.oliver@neukum.org>
In-Reply-To: <200406142341.13340.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>  > userspace daemon loops on ioctl()
>  > kernel portion of ioctl call goes to sleep until something to do
>  > when needed, fill in data and return to userspace
>  > userspace does stuff, then passes data back down via ioctl()
>  > ioctl() puts userspace back to sleep and continues on with other work
> 
> You could just as well implement an ordinary read()

Not quite.  The userspace is passing data down as well.  I don't know how you'd 
do that with read().

Chris
