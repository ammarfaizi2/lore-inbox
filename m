Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUDIBtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 21:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUDIBtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 21:49:19 -0400
Received: from [159.226.248.195] ([159.226.248.195]:52195 "EHLO
	dns.sinosoft.com.cn") by vger.kernel.org with ESMTP id S261648AbUDIBtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 21:49:15 -0400
Message-ID: <40760145.5030109@sinosoft.com.cn>
Date: Fri, 09 Apr 2004 09:49:57 +0800
From: Gewj <geweijin@sinosoft.com.cn>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: zh-cn
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: A puzzling thing about RAID5: syslogd write the log success but
 another process can not read the /var/log/messages
References: <407400F1.8090809@sinosoft.com.cn>	<20040407145126.GA23517@marowsky-bree.de> <16500.35602.13336.290506@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank for your comments

I should say that this question maybe end up without any reasonable result,
the system is now work well , I have give up investigating this problem 
any more.
maybe the question is just cause by the RAID card crash.

Neil Brown wrote:

>On Wednesday April 7, lmb@suse.de wrote:
>  
>
>>On 2004-04-07T21:24:01,
>>   Gewj <geweijin@sinosoft.com.cn> said:
>>
>>    
>>
>>>hammm,tonight is funny because I got a puzzling thing just as....
>>>
>>>my setup is a two-scsi-disk raid5 configuration...
>>>      
>>>
>>Impossible. RAID5 requires at least three disks.
>>    
>>
>
>Wrong.  RAID5 works fine with just two drives.  Try it.
>
>NeilBrown
>
>(I admit that there isn't a lot of point doing raid5 with two drives
>as raid1 should provide identical functionality with better
>performance, but it makes an interesting base-line for performances
>tests on N-drive arrays).
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



