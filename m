Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVCNSC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVCNSC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNR6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:58:46 -0500
Received: from mailhub.sw.ru ([195.133.213.200]:35857 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261659AbVCNRzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:55:44 -0500
Message-ID: <4235CFFD.1040006@vlnb.net>
Date: Mon, 14 Mar 2005 20:55:09 +0300
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: "Moore, Eric Dean" <Eric.Moore@lsil.com>, mpt_linux_developer@lsil.com,
       linux-kernel@vger.kernel.org,
       "Shirron, Stephen" <Stephen.Shirron@lsil.com>
Subject: Re: 2.6: unused code under drivers/message/fusion/
References: <91888D455306F94EBD4D168954A9457C2D1E91@nacos172.co.lsil.com> <4191CD47.1000205@vlnb.net> <20041110094041.GI4089@stusta.de> <4191E657.1030409@vlnb.net> <20050312113142.GB3156@stusta.de>
In-Reply-To: <20050312113142.GB3156@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Nov 10, 2004 at 12:58:47PM +0300, Vladislav Bolkhovitin wrote:
> 
>>Adrian Bunk wrote:
>>
>>>On Wed, Nov 10, 2004 at 11:11:51AM +0300, Vladislav Bolkhovitin wrote:
>>>
>>>
>>>>Moore, Eric Dean wrote:
>>>>
>>>>
>>>>>We need to hold off on this change. Yes, there are 
>>>>>customers of LSI Logic using mptstm.c, as
>>>>>part of the target-mode drivers.  
>>>>>
>>>>>The proposed generic target mode drivers proposal is yet part
>>>>>of the kernel.  
>>>>>http://scst.sourceforge.net/
>>>>>We are looking into supporting this once its available.
>>>>
>>>>Well, SCST is already available, stable and useful. People use it 
>>>>without considerable problems, except with inconvenient LUNs management, 
>>>>which we are going to fix in the next version. I don't expect it will be 
>>>>considering for the kernel inclusion at least until 2.7. So, you can 
>>>>start supporting it right now :-).
>>>
>>>
>>>With the current kernel development model, there is no 2.7 planned for 
>>>the next years.
>>>
>>>Linus and Andrew believe 6 was an odd number, so you could submit your 
>>>code now. [1]
>>
>>OK, I'll prepare the next version as the kernel patch.
> 
> 
> Any news regarding this?

Unfortunately, I have not much time for it now, so I can't expect
release of 0.9.3 version, which is going to have the patch, earlier than
in May. But I'm ready to publish 0.9.3-pre1 as well as some bugfixes in
the Qlogic driver in the nearest future, as soon as I settle down some
untechnical stuff. If somebody is interested, I can send him a copy
privately. As before, it still has ZERO modifications of the kernel, so
it could live perfectly outside the tree.

Also, everybody who think that he/she can help in testing,
developing, bugfixing or just commenting/suggesting are welcome.

Vlad





