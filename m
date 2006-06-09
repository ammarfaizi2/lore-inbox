Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWFIIwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWFIIwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWFIIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:52:24 -0400
Received: from agrajag.inprovide.com ([82.153.166.94]:54686 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S964871AbWFIIwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:52:23 -0400
Message-ID: <41391.194.202.59.51.1149843141.squirrel@mail.inprovide.com>
In-Reply-To: <305c16960606081801y36c90049y2129e4733fa9f954@mail.gmail.com>
References: <200606082233.13720.Sash_lkl@linuxhowtos.org> 
    <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com> 
    <yw1x4pyvdxn4.fsf@agrajag.inprovide.com>
    <305c16960606081801y36c90049y2129e4733fa9f954@mail.gmail.com>
Date: Fri, 9 Jun 2006 09:52:21 +0100 (BST)
Subject: Re: Idea about a disc backed ram filesystem
From: =?utf-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mru@inprovide.com>
To: "Matheus Izvekov" <mizvekov@gmail.com>
Cc: =?utf-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matheus Izvekov said:
> On 6/8/06, Måns Rullgård <mru@inprovide.com> wrote:
>> "Matheus Izvekov" <mizvekov@gmail.com> writes:
>>
>> > My idea consisted of adding the capability to specify a device for
>> > tmpfs mounting. if you dont specify any device, tmpfs continues to
>> > behave the way it currently is. But if you do, once data doesnt fit on
>> > ram (or some other limit) anymore, it will flush things to this
>> > device. my intention was to reuse swap code for this, so you mount a
>> > tmpfs passing the dev node of some unused swap device, and it works
>> > just like tmpfs with a dedicated swap partition.
>>
>> I don't see what advantage this would have over normal tmpfs.
>
> The difference is that the swap device is exclusive for the tmpfs mount.

Yes, and what would the advantage of that be?  Sounds to me you'd only end
up wasting swap space.

-- 
Måns Rullgård
mru@inprovide.com
