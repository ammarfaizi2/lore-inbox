Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVADKXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVADKXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVADKXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:23:33 -0500
Received: from smtpout.mac.com ([17.250.248.46]:60658 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261634AbVADKXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:23:30 -0500
In-Reply-To: <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9F909072-5E3A-11D9-A816-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, Willy Tarreau <willy@w.ods.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Rik van Riel <riel@redhat.com>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Tue, 4 Jan 2005 11:23:06 +0100
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 07:36, Al Viro wrote:

> On Tue, Jan 04, 2005 at 06:46:49AM +0100, Willy Tarreau wrote:
>> On Mon, Jan 03, 2005 at 10:14:42PM +0000, Christoph Hellwig wrote:
>>>> Gosh! I bought an ATI video card, I bought a VMware license, 
>>>> etc.... I
>>>> want to keep using them. Changing a "stable" kernel will 
>>>> continuously
>>>> annoy users and vendors.
>>>
>>> So buy some Operating System that supports the propritary software of
>>> your choice but stop annoying us.
>>
>> That's what he did. But it was not written in the notice that it 
>> could stop
>> working at any time :-)
>
> Do you want a long list of message-IDs going way, way back?  Ones of 
> Linus'
> postings saying that there never had been any promise whatsoever of 
> in-kernel
> interfaces staying unchanged...

  I don't pretend that kernel interfaces stay written in stone, for 
ages. What I would like is that, at least, those interfaces were stable 
enough, let's say for a few months for a stable kernel series, so I 
don't have to keep bothering my propietary VMWare vendor to fix the 
problems for me, since the new kernel interface broke VMWare. Yeah, I 
know I could decide not to upgrade kernels in last instance, but that's 
not always possible.

If kernel interfaces need to be changed for whatever reason, change 
them in 2.7, -mm, -ac or whatever tree first, and let the community 
know beforehand what those changes will be, and be prepared to adapt. 
Meanwhile, try to leave 2.6 as stable as possible.

