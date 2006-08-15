Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752097AbWHODso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbWHODso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbWHODso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:48:44 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:53818 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752096AbWHODsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:48:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Movn9clWVb5TNbZFfvDoMfKc54GcEHm8awqfTiwy00cmENmgbx0z+ZirmysM8bzM+8TxR6VW6paaJG3Ds5HFdP3oXfM/wqrNvs/xMp5LEvmeGG2unEvdT4ffgDP5OM2pkKJySo3kqLSNSQ9W7EmNJ6XCSMKbjQQ/VhzPn+9yVzY=
Message-ID: <44E14406.7020208@ak.jp.nec.com>
Date: Tue, 15 Aug 2006 12:48:22 +0900
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <44E1153D.9000102@ak.jp.nec.com> <20060815021612.GC16220@sergelap.austin.ibm.com>
In-Reply-To: <20060815021612.GC16220@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: KaiGai Kohei <kaigai.kohei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> See
>> http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d
>> http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm
>>
>> The later SRPM package includes the cap_file.c.
>> It will be a good sample of using libcaps.
> 
> And this has a version number built in, as Eric was asking for.

_LINUX_CAPABILITY_VERSION defined as 0x19980330 is used for this.
Is there a possibility to be changed future, isn't it?
For example, when we think 32-bit width is not enough.

> My tools were purely for testing, and just kept everything as simple as
> possible.  So I'll happily port the kernel patch to use your tools  :)
> 
> For that matter I see you have your own kernel patch.  Would you mind
> submitting that to lkml as an alternative to mine?

I have no plan to submit now. It'll be called "Re-investment of wheel".
# In addition, I'm currently busy to hack PostgreSQL. :D

I hope to confirm one more point.
Endian conpatibility is considered in the patches?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>
