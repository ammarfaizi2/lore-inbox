Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUJCOUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUJCOUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 10:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUJCOUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 10:20:55 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:45801 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S267958AbUJCOUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 10:20:53 -0400
Message-ID: <415F1061.10904@magma.ca>
Date: Sat, 02 Oct 2004 16:32:33 -0400
From: Jesse <ottdot@magma.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitch <Mitch@HasBox.COM>
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
References: <415FFE77.7090908@HasBox.COM>
In-Reply-To: <415FFE77.7090908@HasBox.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitch wrote:
> Hi Jesse,
> 
> as shown below, that is  not one of the options presented to me in my 
> 'disk' file
> 
> % cat /sys/power/disk
> shutdown
> 

My machine shows the same thing. Only shutdown in /sys/power/disk

Grab the code from Documentation/power/swsusp.txt (starts at line 151)

I compiled it to an executable called swsusp and I then run 'swsusp' to 
start the suspend process.

2.6.9-rc3 was my first attempt at suspend, and it worked as designed on 
the first try.

Jesse

