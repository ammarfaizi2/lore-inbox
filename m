Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031645AbWLARNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031645AbWLARNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031648AbWLARNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:13:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:29885 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1031645AbWLARNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:13:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        b=fv+Iz5eGb/j2mnGqM3l1ZRK2JhmgzJgSXxoHPcHMf09iYHC17DVed2L5Jvyb3eD1xMPNxT1CVQ/rROjEoRcbrhieJOsnAh6I0+0QdxelQYuLrhqNgNOccppA1pUXyo/Gb56B+tmnETItSHDX3TQf35UYqK9nHm0jGkXPPZuLQsU=
In-Reply-To: <20061201165638.7d5f1c4e@localhost.localdomain>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> <11648607733630-git-send-email-bcollins@ubuntu.com> <20061201132918.GB4239@ucw.cz> <1164980500.5257.922.camel@gullible> <1164983529.3233.73.camel@laptopd505.fenrus.org> <1164985757.5257.933.camel@gullible> <1164989436.3233.85.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612010815510.3695@woody.osdl.org> <20061201165638.7d5f1c4e@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3A09DC0-99E4-4F0F-BFB6-33FD6B4C7766@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable hyper-threading.
Date: Fri, 1 Dec 2006 11:13:27 -0600
To: Alan <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.752.2)
From: Mark Rustad <mrustad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 1, 2006, at 10:56 AM, Alan wrote:
>> So I think people have blown those SSL timing attacks _way_ out of
>> proportion, just because it sounds technical and cool.
>>
>> Besides, most of the time you can disable HT in the BIOS, which is  
>> better
>> anyway if you don't want it.
>
> Agreed - but the SSL thing is an irrelevance. The main reason for
> disabling HT (especially on a single core CPU) is because a lot of
> workloads run faster with HT *off*.

Yes. Another way to effectively turn it off is to set maxcpus to the  
number of physical cpus in your system. So far I have not encountered  
a system that that approach does not work on.

-- 
Mark Rustad, MRustad@mac.com

