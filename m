Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbTGVDjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbTGVDjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 23:39:18 -0400
Received: from lakemtao08.cox.net ([68.1.17.113]:5049 "EHLO lakemtao08.cox.net")
	by vger.kernel.org with ESMTP id S269218AbTGVDjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 23:39:17 -0400
Message-ID: <3F1CB567.5050103@cox.net>
Date: Mon, 21 Jul 2003 22:54:15 -0500
From: Yuliy Pisetsky <mentalchaos@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andreas baeurle <a.baeurle@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: XP vfat partitions
References: <bfechu$tse$1@main.gmane.org> <20030721175147.GD1158@matchmail.com> <bfhp94$1cr$1@main.gmane.org>
In-Reply-To: <bfhp94$1cr$1@main.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andreas baeurle wrote:

>Mike Fedyk wrote:
>
>  
>
>>On Sun, Jul 20, 2003 at 05:27:03PM +0200, andreas wrote:
>>    
>>
>>>My question is howto mount a Xp-vfat partition with 2.6 kernel.
>>>In my fstab is following entry:
>>>/dev/hda2       /windows/C      vfat   
>>>users,gid=users,umask=0002,iocharset=iso8859-1 code=437 0 0
>>>      
>>>
>>Yes?
>>
>>And what is your error message, and why do you think it's not working
>>anymore?
>>    
>>
>I have 3 Partitions with vfat
>the error message is:
><3>FAT: Unrecognized mount option code
><3>FAT: Unrecognized mount option code
><3>FAT: Unrecognized mount option code
>in boot.msg
>I have testet lsmod it shows me one vfat module loaded but not used
>
>thanks
>andreas
>
hmmm... why is the code=437 separate? Try replacing the space before 
code=437 with a comma.
-Yuliy Pisetsky

