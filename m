Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272761AbTG3FF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272762AbTG3FF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:05:58 -0400
Received: from outmail.cc.huji.ac.il ([132.64.1.21]:24462 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S272761AbTG3FF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:05:56 -0400
Message-ID: <3F2746F5.4010702@mscc.huji.ac.il>
Date: Wed, 30 Jul 2003 07:17:57 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
Organization: Hebrew University of Jerusalem
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Voluspa <lista1@telia.com>, s.rivoir@gts.it
Subject: Re: Disk performance degradation
References: <20030729182138.76ff2d96.lista1@telia.com> <3F26A5E2.4070701@aros.net>
In-Reply-To: <3F26A5E2.4070701@aros.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (pluto.mscc.huji.ac.il)
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.20.0.1; VDF: 6.20.0.26; host: mail3.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:
> Voluspa wrote:
> 
>> On 2003-07-29 12:00:06 Stefano Rivoir wrote:
>>
>>  
>>
>>> Is there something I'm missing?!
>>>   
>>
>>
>> No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
>> 512". See thread for explanation (it's the borked value for readahead):
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=105830624016066&w=2
>>
> Anyone want to field why we aren't we just setting the default to 512 so 
> users don't need to adjust this? I'm sure there's a good reason... I'd 
> just like to know what it is ;-)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Good Idea, what could be the reason?

-- 
Voicu Liviu
Rothberg International School
Computation center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: pacman@mscc.huji.ac.il

Operating System: Linux Gentoo1.4 ( www.gentoo.org )

Click here to see my GPG signature:
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List

