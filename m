Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWJIHAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWJIHAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWJIHAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:00:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:20836 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751697AbWJIHAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nM1VcNTvYy+hvTqt68yKxy+DvLWAhEkM5Lg64W9TV4foVxdMeujUIwtlfc9KqPkOa2Ist7GFjxu5JmfajuNnD0P+lLNoTvwqq3sNRP75gbho6caSq01o5JgR+k2hIU1M6nxxGW42h3EcVTDyI+uWQfLh7l3y1dDP3KojETCzbAA=
Message-ID: <4529F391.3030504@gmail.com>
Date: Mon, 09 Oct 2006 16:00:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Joe Jin <lkmaillist@gmail.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com> <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
In-Reply-To: <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Jin wrote:
>> SRST failure would have still occurred but 30sec timeout should have
>> gone.  Can you post full dmesg?
> 
> Yes it is.
> attachment is the output of dmesg

Great.

>> Also, please test the patch in the following mail.  You can use either
>> git or download the full kernel tarball to get the modified kernel.
>>
> 
> Did the pathc against 2.6.19-rc1?
> I have test it, but it have not any change and timeout also appeared :(

It's against libata development tree.  So, you downloaded the tar.gz and 
tested it?

Thanks.

-- 
tejun
