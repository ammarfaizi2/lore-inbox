Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276190AbRJGH02>; Sun, 7 Oct 2001 03:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276208AbRJGH0S>; Sun, 7 Oct 2001 03:26:18 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:16140 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S276190AbRJGH0H> convert rfc822-to-8bit; Sun, 7 Oct 2001 03:26:07 -0400
Date: Sun, 7 Oct 2001 09:21:05 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jes Sorensen <jes@sunsite.dk>
Cc: <paulus@samba.org>, "David S. Miller" <davem@redhat.com>,
        <James.Bottomley@HansenPartnership.com>, <linuxopinion@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to get virtual address from dma address
In-Reply-To: <d3adz4u1gx.fsf@lxplus014.cern.ch>
Message-ID: <20011007091404.X953-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Oct 2001, Jes Sorensen wrote:

> >>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:
>
> Paul> David S. Miller writes:
> >> I can not even count on one hand how many people I've helped
> >> converting, who wanted a bus_to_virt() and when I showed them how
> >> to do it with information the device provided already they said "oh
> >> wow, I never would have thought of that".  That process won't
> >> happen as often with the suggested feature.
>
> Paul> Well, let's see if we can come up with a way to achieve this
> Paul> goal as well as the other.
>
> Paul> I look at all the hash-table stuff in the usb-ohci driver and I
> Paul> think to myself about all the complexity that is there (and I
> Paul> haven't managed to convince myself yet that it is actually
> Paul> SMP-safe) and all the time wasted doing that stuff, when on
> Paul> probably 95% of the machines that use the usb-ohci driver, the
> Paul> hashing stuff is totally unnecessary.  I am talking about
> Paul> powermacs, which don't have an iommu, and where the reverse
> Paul> mapping is as simple as adding a constant.
>
> I haven't looked at the ohci driver at all, however doesn't it return
> anything but the dma address? No index, no offset, no nothing? If
> thats the case, someone really needs to go visit the designers with a
> large bat ;-(

I would apply the bat to people that wants such a dma to virtual general
translation. This thing is obviously gross shit.

I would also apply the bat to people that look into stuff of other people
and, instead of trying to actually understand the code, just give a look
and send inappropriate statements to the list.

  Gérard.

