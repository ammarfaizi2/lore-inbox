Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJ2Igs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJ2Igs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJ2Igs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:36:48 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:33455 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750757AbVJ2Igr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:36:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xDGWdgUHzL4m6SvAtHDXDbS7JxnQQm56rY/5ae1LWZ512fSP5z4aLgKiW1xane6P2IrhxGEGAJ/bCnFv3rcJxiGRrEwLd1TtQYjL9qQ1xFHk+r+jkHGuvof3TPI7q0QspC2EtOl8kCYKe24ZoaDAZVx8u4iWuTnk3f3xXg26Hqo=  ;
Message-ID: <43633507.2050006@yahoo.com.au>
Date: Sat, 29 Oct 2005 18:38:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com> <4362BA30.2020504@pobox.com> <4362A9A7.2090101@utah-nac.org> <4362E329.8040204@yahoo.com.au> <4362E71A.6030904@utah-nac.org> <4362E7B3.6020509@utah-nac.org>
In-Reply-To: <4362E7B3.6020509@utah-nac.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:
> jmerkey wrote:

>> Yes I did. The list wasn't too long. I had problems with RCU messages 
>> and irq warn messages at very high loads and init respawning itself 
>> subjected to loads > 369 MB/S to the disk channels on 2.6.13. 
>> Performance was down on disk I/O [vs.] 2.6.9. I did not investigate 
>> the BIO fixes but something changed there. Theres also some memory 
>> problems with corruption somewhere in the 2.6.14 (during module unload 
>> and shutdown).
>>

Well that doesn't sound too good. It would be good if you could document
and report each problem - the messages, workload, kernel config and any
patches used, etc. And post them to lkml. Hopefully they can get sorted
out.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
