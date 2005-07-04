Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVGDGao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVGDGao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVGDGan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:30:43 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:950
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261516AbVGDGaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:30:39 -0400
Message-ID: <42C8C978.4030409@linuxwireless.org>
Date: Mon, 04 Jul 2005 00:30:32 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de>
In-Reply-To: <20050704061713.GA1444@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Jul 04 2005, Lenz Grimmer wrote:
>  
>
>>>I'll be working on adding sysfs stuff to it tomorrow so it's generally
>>>useful (at least for monitoring things - not yet for parking disk
>>>heads).
>>>      
>>>
>>Maybe there is some kind of all-purpose ATA command that instructs the
>>disk drive to park the heads? Jens, could you give us a hint on how a
>>userspace application would do that?
>>    
>>
>
>Dunno if there's something that explicitly only parks the head, the best
>option is probably to issue a STANDBY_NOW command. You can test this
>with hdparm -y.
>  
>
This is exactly what I said. Use hdparm to make the HD park 
inmediatelly. I did send the email to the HDPARM developer, but he never 
replied. I asked him what would be the best way to make the HD park with 
no exception and then let it come back 5 or 10 seconds later.

Never heard back. ;-(

.Alejandro
