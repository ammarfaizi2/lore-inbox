Return-Path: <linux-kernel-owner+w=401wt.eu-S1751693AbWLMXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWLMXHd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWLMXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:07:33 -0500
Received: from smtpout.mac.com ([17.250.248.171]:49439 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbWLMXHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:07:33 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:07:33 EST
In-Reply-To: <f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <20061213210219.GA9410@suse.de> <45807182.1060408@mbligh.org> <20061213134721.d8ff8c11.akpm@osdl.org> <f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ECF27505-1BA5-41F6-A0EB-BB98C5050643@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Wed, 13 Dec 2006 17:59:14 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-13_10:2006-12-13,2006-12-13,2006-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0612050001 definitions=main-0612130066
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 13, 2006, at 17:20:35, Michael K. Edwards wrote:
> On 12/13/06, Andrew Morton <akpm@osdl.org> wrote:
>> On Wed, 13 Dec 2006 13:32:50 -0800 Martin Bligh  
>> <mbligh@mbligh.org> wrote:
>>> So let's come out and ban binary modules, rather than  
>>> pussyfooting around, if that's what we actually want to do.
>>
>> Give people 12 months warning (time to work out what they're going  
>> to do, talk with the legal dept, etc) then make the kernel load  
>> only GPL-tagged modules.
>
> IIRC, Linus has deliberately and explicitly estopped himself from  
> claiming that loading a binary-only driver is a GPL violation.  Do  
> you really want to create an arbitrage opportunity for  
> intermediaries who undo technical measures that don't match Linus's  
> declared policy or, in many people's opinion, the law in at least  
> some jurisdictions? (I'm not going to go all amateur-lawyer on you,  
> but the transcript of oral argument at the Supreme Court level in  
> Lotus v. Borland makes really interesting reading no matter where  
> you live or what your stance is on GPL-and-linking.)

Ok, so what Linus said is true for any code that _Linus_ wrote up  
until this point.  It is perfectly fine for the iptables developers  
to say "I think linking with my GPL IPTables code for makes your code  
a derivative work of mine", although I don't really have the legal  
knowledge to argue technical points either way.

Corporations change their mind on licensing all the time; though you  
can never revoke privileges you already granted on existing  
materials. As soon as you start creating new material (in the Linux  
case at a rate of multiple megs per month) you can set new licensing  
requirements on that new code as long as it's compatible with the  
requirements on the old code which it's linked against.

Cheers,
Kyle Moffett

